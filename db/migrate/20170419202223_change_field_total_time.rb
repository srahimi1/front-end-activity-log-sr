class ChangeFieldTotalTime < ActiveRecord::Migration[5.0]
  def change
  	change_column :timelogs, :total_time, :string
  end
end
