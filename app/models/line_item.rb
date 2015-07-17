class LineItem < ActiveRecord::Base

  validates_presence_of :product, :qty

  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def amount
    self.product.price * self.qty
  end

end
