class CreateEventGroupships < ActiveRecord::Migration
  def change
    create_table :event_groupships do |t|

      t.integer :event_id
      t.integer :group_id

      t.timestamps null: false
    end

    add_index :event_groupships, :event_id
    add_index :event_groupships, :group_id
  end
end
