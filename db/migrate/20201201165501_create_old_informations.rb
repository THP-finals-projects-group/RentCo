class CreateOldInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :old_informations do |t|
      t.int :project_id,      null: false
      t.int :type_id,         null: false
      t.int :surface,         null: false
      t.int :rooms_count,     null: false

      t.timestamps
    end
  end
end
