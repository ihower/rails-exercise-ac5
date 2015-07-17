class Product < ActiveRecord::Base

  validates_presence_of :title, :price

  def out_of_stock?
    self.qty_in_stock <= 0
  end

end
