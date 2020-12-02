class CreateCases < ActiveRecord::Migration[5.2]
  def change
    create_table :cases do |t|
      t.string :title,                    unique: true, null: false 
      t.string :case_reference,           null: false, default: "Matthieu Gilette"
      t.text :contact_referent,           null: false
      t.string :street_number,            null: false
      t.string :street_name,              null: false 
      t.string :city,                     null: false
      t.string :zipcode,                  null: false, limit: 5
      t.string :longitude
      t.string :latitude
      t.datetime :visit_date,             null: false
      t.boolean :is_confirmed,            null: false, default: false     
      t.text :physical_description,       limit: 500
      t.text :geographical_description,   limit: 500  
      t.text :potential_description,      limit: 500 
      t.integer :old_information_id          
      t.integer :total_monthly_charge
      t.integer :water_cost
      t.integer :electricity_cost
      t.integer :union_charges_cost
      t.integer :common_charges_cost
      t.integer :total_buying_price
      t.integer :seller_price
      t.integer :estimated_negociation
      t.integer :notary_charges
      t.integer :property_taxes
      t.integer :renovation_union
      t.integer :renovation_id
      t.integer :new_information_id
      t.integer :pno_insurance_cost,          null: false
      t.integer :rent_annual_estimations_total_cost
      t.integer :month_count
      t.integer :total_rent_monthly
      t.float :renta_brut
      t.float :renta_net

      t.timestamps
    end
  end
end
