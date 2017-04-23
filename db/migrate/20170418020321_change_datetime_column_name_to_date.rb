class ChangeDatetimeColumnNameToDate < ActiveRecord::Migration[5.0]
  def change
  	rename_column :timelogs, :datetime, :log_date
  end
end
