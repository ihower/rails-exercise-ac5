class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.integer :price
      # t.string :currency
      t.text :description
      t.string :image_url
      t.integer :qty_in_stock, :default => 0
      t.timestamps null: false
    end
  end
end
