class AddDatetimeToEvents < ActiveRecord::Migration

  def change
    add_column :events, :start_on, :date
    add_column :events, :schedule_at, :datetime
  end

end
