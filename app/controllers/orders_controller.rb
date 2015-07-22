class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find( params[:id] )
  end

  def new
    @order = current_user.orders.build

    @order.email = current_user.email
  end

  def create
    @order = current_user.orders.build( order_params )
    @order.add_line_items(current_cart)

    if @order.save
      cookies[:cart_id] = nil

      if @order.payment_method == "allpay"

        redirect_to checkout_allpay_order_path(@order)
      else
        redirect_to products_path
      end

    else
      render :new
    end
  end

  def checkout_allpay
    @order = current_user.orders.find( params[:id] )

    if @order.paid?
      redirect_to products_path, alert: 'already paid!'
    else
      @payment = PaymentAllpay.create!( :order => @order,
                                        :payment_method => "Credit" )
      render :layout => false
    end
  end

  protected

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address, :payment_method)
  end
end
