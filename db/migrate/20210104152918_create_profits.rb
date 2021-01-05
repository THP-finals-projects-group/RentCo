class CreateProfits < ActiveRecord::Migration[5.2]
  def change
    create_table :profits do |t|
      t.integer :new_rooms_count
      t.integer :total_rent_annual_estimations
      t.integer :month_count
      t.integer :total_rent_monthly
      t.float :renta_brut
      t.float :renta_net

      t.timestamps
    end
  end
end
