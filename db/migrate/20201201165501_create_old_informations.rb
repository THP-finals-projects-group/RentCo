class CreateOldInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :old_informations do |t|
      t.integer :surface,         null: false
      t.integer :rooms_count,     null: false

      t.belongs_to :type
      t.belongs_to :project

      t.timestamps
    end
  end
end
