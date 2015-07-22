module AllpayHelper

  def generate_allpay_params(payment)
      allpay_params = {
        MerchantID: Allpay.merchant_id,
        MerchantTradeNo: "#{payment.id}AC#{Rails.env.upcase[0]}",
        MerchantTradeDate: Time.now.strftime('%Y/%m/%d %H:%M:%S'),
        PaymentType: :aio,
        TotalAmount: payment.amount,
        TradeDesc: payment.name,
        ItemName: payment.items.join('#'),
        ChoosePayment: payment.payment_method,
        ReturnURL: Allpay.return_url,
        OrderResultURL: allpay_result_url
      }

      allpay = Allpay.new(allpay_params)
      allpay_params[:CheckMacValue] = allpay.make_mac
      allpay_params
  end

end
