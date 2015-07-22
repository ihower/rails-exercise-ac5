require 'allpay'
allpay_config = Rails.application.config_for(:allpay)

Allpay.setup do |config|
  config.merchant_id = allpay_config["merchant_id"]
  config.hash_key = allpay_config["hash_key"]
  config.hash_iv = allpay_config["hash_iv"]
  config.url = allpay_config["url"]
  config.return_url = allpay_config["return_url"]
end