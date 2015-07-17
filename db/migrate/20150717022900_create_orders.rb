class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address

      t.string :payment_method # credit_card, atm..etc
      t.integer :amount

      t.timestamps null: false
    end
  end
end
