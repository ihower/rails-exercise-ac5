class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def buy
    @product = Product.find( params[:id] )

    current_cart.add_line_item( @product )

    redirect_to :back
  end

end
