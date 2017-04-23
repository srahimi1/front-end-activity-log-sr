class CreateCollaborations < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborations do |t|
      t.belongs_to :project
      t.integer :collaborator_id
      t.string :role

      t.timestamps
    end
  end
end
