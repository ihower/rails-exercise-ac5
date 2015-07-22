class PaymentAllpay < Payment

  validate :check_mac, on: :update

  PAYMENT_METHODS = %w[Credit WebATM ATM CVS BARCODE] # Alipay Tenpay

  validates_inclusion_of :payment_method, :in => PAYMENT_METHODS

  def self.find_and_process(params)
    payment = self.find(params[:MerchantTradeNo].to_i)
    payment.paid = params['RtnCode'] == '1'
    payment.params = params
    payment
  end

  private

  def check_mac
    allpay = Allpay.new(self.params)
    errors.add(:params, 'wrong mac value') unless allpay.check_mac
  end

end

