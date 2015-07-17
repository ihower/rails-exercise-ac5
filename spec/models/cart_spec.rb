require 'rails_helper'

RSpec.describe Cart, type: :model do

  before do
    @cart = Cart.create!
    @product1 = Product.create!( :title => "A", :price => 10)
    @product2 = Product.create!( :title => "B", :price => 20)
  end

  describe "#add_line_item" do
    it "should add product to cart.line_items" do
      @cart.add_line_item(@product1)

      expect( @cart.line_items.count ).to eq(1)

      item = @cart.line_items.first

      expect( item.product ).to eq( @product1 )
      expect( item.qty ).to eq( 1 )
    end

    it "should add two products to cart.line_items" do
      @cart.add_line_item(@product1)
      @cart.add_line_item(@product2)

      expect( @cart.line_items.count ).to eq(2)

      item1 = @cart.line_items.first
      item2 = @cart.line_items.last

      expect( item1.product ).to eq( @product1 )
      expect( item1.qty ).to eq( 1 )

      expect( item2.product ).to eq( @product2 )
      expect( item2.qty ).to eq( 1 )
    end

    it "should add the same product twice to cart.line_items" do
      @cart.add_line_item(@product1)
      @cart.add_line_item(@product1)

      expect( @cart.line_items.count ).to eq(1)

      item = @cart.line_items.first

      expect( item.product ).to eq( @product1 )
      expect( item.qty ).to eq( 2 )
    end

  end

end
