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
      t.int :old_information_id
      t.text :physical_description,       limit: 500
      t.text :geographical_description,   limit: 500  
      t.text :potential_description,      limit: 500           
      t.int :total_monthly_charges
      t.int :water_cost
      t.int :electricity_cost
      t.int :union_charges_cost
      t.int :common_charges_cost
      t.int :total_buying_price
      t.int :seller_price
      t.int :estimated_negociation
      t.int :notary_charges
      t.int :property_taxes
      t.int :renovation_union
      t.int :renovation_id
      t.int :new_information_id
      t.int :pno_insurance_cost,          null: false
      t.int :rent_annual_estimation_id
      t.float :renta_brut
      t.float :renta_net
      t.references :room_id,              foreign_key: true
      t.int :rent_annual_estimations_total_cost
      t.int :month_count
      t.int :total_rent_monthly

      t.timestamps
    end
  end
end
