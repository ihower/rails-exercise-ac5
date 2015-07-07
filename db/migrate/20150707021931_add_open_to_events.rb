class AddOpenToEvents < ActiveRecord::Migration

  def change
    add_column :events, :is_open, :boolean, :default => false
  end

end
