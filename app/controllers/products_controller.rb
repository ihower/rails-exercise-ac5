class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def buy
    @product = Product.find( params[:id] )

    if @product.out_of_stock?
      flash[:alert] = "Out of Stock!"
    else
      current_cart.add_line_item( @product )
    end

    redirect_to :back
  end

end
