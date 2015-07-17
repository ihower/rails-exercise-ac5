class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items, :dependent => :destroy

  def add_line_items(cart)
    cart.line_items.each do |cart_item|
      self.line_items.build( :product => cart_item.product,
                             :qty => cart_item.qty )
    end

    self.amount = cart.amount
  end

end
