class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|

      t.string :type  # AllpayPayment or PaypalPayment
      t.string :payment_method
      t.integer :order_id
      t.integer :amount
      t.boolean :paid, :default => false
      t.text    :params

      t.timestamps null: false
    end

    add_index :payments, :order_id

    add_column :orders, :payment_status, :string, :default => "pending"

    add_column :orders, :shipping_status, :string, :default => "pending"

  end
end
