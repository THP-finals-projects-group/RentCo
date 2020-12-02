class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :rent_monthly,  null: false
      t.references :cases,      foreign_key: true
      t.timestamps
    end
  end
end
