class CreateUbikes < ActiveRecord::Migration
  def change
    create_table :ubikes do |t|

      t.string :iid, :index => true

      t.string :name

      t.text :data

      t.timestamps null: false
    end

  end
end
