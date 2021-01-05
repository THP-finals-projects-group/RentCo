class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.integer :total_monthly_charges
      t.integer :water_cost
      t.integer :heater_cost
      t.integer :electricity_cost
      t.integer :union_charges_cost
      t.integer :common_charges_cost
      t.integer :total_buying_price
      t.integer :seller_price
      t.integer :estimated_negociation
      t.integer :notary_charges
      t.integer :property_taxes
      t.integer :agency_charges
      t.integer :renovation_union

      t.timestamps
    end
  end
end
