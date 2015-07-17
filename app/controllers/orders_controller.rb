class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    @order = current_user.orders.build

    @order.email = current_user.email
  end

  def create
    @order = current_user.orders.build( order_params )
    @order.add_line_items(current_cart)

    if @order.save
      session[:cart_id] = nil
      redirect_to products_path
    else
      render :new
    end
  end

  protected

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address)
  end
end
