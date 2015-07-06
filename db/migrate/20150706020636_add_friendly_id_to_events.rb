class AddFriendlyIdToEvents < ActiveRecord::Migration

  def change
    add_column :events, :friendly_id, :string
    add_index :events, :friendly_id, :unique => true
  end

end
