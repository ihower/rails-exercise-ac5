class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :name

      t.integer :event_id

      t.timestamps null: false
    end

    add_index :attendees, :event_id

  end
end
