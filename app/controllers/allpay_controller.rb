require 'allpay'
class AllpayController < ApplicationController
  skip_before_action :verify_authenticity_token

  def result
    @payment = PaymentAllpay.find_and_process(request.POST)
    @payment.save

    redirect_to order_path(@payment.order)
  end

  def return
    @payment = PaymentAllpay.find_and_process(request.POST)

    if @payment.save
      render :text => "1|OK"
    else
      render :text => "0|ErrorMessage"
    end
  end


end