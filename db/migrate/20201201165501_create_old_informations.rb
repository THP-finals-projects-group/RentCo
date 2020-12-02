class CreateOldInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :old_informations do |t|
      t.integer :project_id,      null: false
      t.integer :type_id,         null: false
      t.integer :surface,         null: false
      t.integer :rooms_count,     null: false
      t.belongs_to :cases
      t.timestamps
    end
  end
end
