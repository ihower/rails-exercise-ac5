class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items, :dependent => :destroy

  validate :check_product_qty
  after_create :update_product_qty

  def paid?
    self.payment_status == "paid"
  end

  def add_line_items(cart)
    cart.line_items.each do |cart_item|
      self.line_items.build( :product => cart_item.product,
                             :qty => cart_item.qty )
    end

    self.amount = cart.amount
  end

  def check_product_qty
    self.line_items.each do |item|
      p = item.product
      p.lock!

      pq = item.product.qty_in_stock

      if item.qty > pq
        errors[:base] = "#{p.title} out of stock"
      end
    end
  end

  def update_product_qty
    self.line_items.each do |item|
      p = item.product
      p.qty_in_stock -= item.qty
      p.save!
    end
  end

end
