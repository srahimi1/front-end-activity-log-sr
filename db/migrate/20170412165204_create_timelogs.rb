class CreateTimelogs < ActiveRecord::Migration[5.0]
  def change
    create_table :timelogs do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.datetime :datetime
      t.text :note
      t.time :total_time

      t.timestamps
    end
  end
end
