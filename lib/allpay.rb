# Original version credit: tonytonyjan
# https://github.com/tonytonyjan/allpay/blob/master/lib/allpay/client.rb
class Allpay

  mattr_accessor :merchant_id
  mattr_accessor :hash_key
  mattr_accessor :hash_iv
  mattr_accessor :url
  mattr_accessor :return_url

  def initialize(params)
    data = params.stringify_keys
    @check_mac_value = data.delete('CheckMacValue')
    @params = data
  end

  def self.setup
    yield(self)
  end

  def make_mac
    raw = @params.sort.map!{|ary| "#{ary.first}=#{ary.last}"}.join('&')
    padding = "HashKey=#{hash_key}&#{raw}&HashIV=#{hash_iv}"
    url_encoded = CGI.escape(padding).downcase!
    Digest::MD5.hexdigest(url_encoded).upcase!
  end

  def check_mac
    make_mac == @check_mac_value
  end

end