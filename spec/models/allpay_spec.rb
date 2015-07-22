require 'rails_helper'

RSpec.describe Allpay, type: :model do

  it '#make_make' do
    Allpay.setup do |config|
      config.merchant_id = '12345678'
      config.hash_key = 'xdfaefasdfasdfa32d'
      config.hash_iv = 'sdfxfafaeafwexfe'
    end

    allpay = Allpay.new({
      ItemName: 'sdfasdfa',
      MerchantID: '12345678',
      MerchantTradeDate: '2013/03/12 15:30:23',
      MerchantTradeNo: 'allpay_1234',
      PaymentType: 'allpay',
      ReturnURL: 'http:sdfasdfa',
      TotalAmount: '500',
      TradeDesc: 'dafsdfaff'
    })

    expect( allpay.make_mac ).to eq('40D9A6C00A4A78A300ED458237071BDA')
  end

  it '#check_mac' do
    Allpay.setup do |config|
      config.merchant_id = '2000132'
      config.hash_key = '5294y06JbISpM5x9'
      config.hash_iv = 'v77hoKGq4kWxNNIS'
    end

    allpay = Allpay.new({
      RtnCode: '1',
      PaymentType: 'Credit_CreditCard',
      TradeAmt: '700',
      PaymentTypeChargeFee: '14',
      PaymentDate: '2015/02/07 14:21:00',
      SimulatePaid: '0',
      CheckMacValue: '3AF270CCCFA58CA0349F4FD462E21643',
      TradeDate: '2015/02/07 14:20:47',
      MerchantID: '2000132',
      TradeNo: '1502071420478656',
      RtnMsg: '交易成功',
      MerchantTradeNo: '355313'
    })
    expect( allpay.check_mac ).to eq(true)
  end

end
