class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :status
      t.integer :created_by

      t.timestamps
    end
  end
end
