class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|

      t.string :title
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :todos, :user_id
  end

end
