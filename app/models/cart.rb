class Cart < ActiveRecord::Base

  has_many :line_items, :dependent => :destroy

  def amount
    self.line_items.map{ |x| x.amount }.sum
  end

  def add_line_item(product)
    item = self.line_items.find_by_product_id( product.id )

    if item
      item.qty += 1
    else
      item = self.line_items.build( :product => product, :qty => 1 )
    end

    item.save
    return item
  end

end
