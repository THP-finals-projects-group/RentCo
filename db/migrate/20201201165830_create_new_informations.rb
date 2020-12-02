class CreateNewInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :new_informations do |t|
      t.integer :project_id
      t.integer :type_id
      t.integer :surface,         null: false
      t.integer :rooms_count,     null: false

      t.timestamps
    end
  end
end
