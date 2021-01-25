class CreateCases < ActiveRecord::Migration[5.2]
  def change
    create_table :cases do |t|
      
      t.boolean :is_confirmed,                           null: false, default: false
      t.references :user,                                foreign_key: true, null: false

      t.timestamps
    end
  end
end
