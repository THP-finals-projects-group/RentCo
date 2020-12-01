class CreateNewInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :new_informations do |t|
      t.int :project_id
      t.int :type_id
      t.int :surface,         null: false
      t.int :rooms_count,     null: false

      t.timestamps
    end
  end
end
