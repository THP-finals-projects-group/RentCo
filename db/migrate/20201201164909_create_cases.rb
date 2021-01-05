class CreateCases < ActiveRecord::Migration[5.2]
  def change
    create_table :cases do |t|
      # 1st new controller
      t.string :title,                                   unique: true, null: false 
      t.string :case_reference,                          null: false
      t.text :contact_referent,                          null: false, default: "Matthieu Gilette"
      t.string :street_number,                           null: false
      t.string :street_name,                             null: false 
      t.string :city,                                    null: false
      t.string :zipcode,                                 null: false, limit: 5
      t.float :longitude
      t.float :latitude
      t.datetime :visit_date,                            null: false
      t.boolean :is_confirmed,                           null: false, default: false     
      t.text :physical_description,                      limit: 500
      t.text :geographical_description,                  limit: 500
      t.text :potential_description,                     limit: 500
      # old_information
      t.integer :old_surface,                             null: false, default: 0
      t.integer :old_rooms_count,                         null: false, default: 0
      t.string :old_type,                                 null: false
      t.string :old_project,                              null: false
      # BELOW ADMIN PART // ABOVE USER PART
      # monthly charges
      # 2nd new controller
      t.integer :total_monthly_charges
      t.integer :water_cost,                              default: 0
      t.integer :heater_cost,                             default: 0
      t.integer :electricity_cost,                        default: 0
      t.integer :union_charges_cost,                      default: 0
      t.integer :common_charges_cost,                     default: 0
      # buying price
      t.integer :total_buying_price
      t.integer :seller_price,                            default: 0
      t.integer :estimated_negociation,                   default: 0
      t.integer :notary_charges,                          default: 0
      t.integer :property_taxes,                          default: 0
      t.integer :agency_charges,                          default: 0
      t.integer :renovation_union,                        default: 0
      # renovation
      # 3rd new controller
      t.integer :pno_insurance_cost
      t.integer :pre_estimation_renovation_cost
      t.integer :indicator_pre_estimation_renovation
      t.integer :total_renovation_cost
      t.integer :renovation_demolition_cost,              default: 0
      t.integer :renovation_preparation_cost,             default: 0
      t.integer :renovation_carpentry_cost,               default: 0
      t.integer :renovation_plastering_cost,              default: 0
      t.integer :renovation_electricity_cost,             default: 0
      t.integer :renovation_plumbing_cost,                default: 0
      t.integer :renovation_wall_ceiling_cost,            default: 0
      t.integer :renovation_painting_cost,                default: 0
      t.integer :renovation_flooring_cost,                default: 0
      t.integer :renovation_kitchen_cost,                 default: 0
      t.integer :renovation_furniture_cost,               default: 0
      t.integer :renovation_facade_cost,                  default: 0
      t.integer :renovation_security_cost,                default: 0
      t.integer :renovation_masonry_cost,                 default: 0
      t.integer :renovation_covering_cost,                default: 0      
      # new_information
      t.integer :new_surface,                             default: 0
      t.string :new_type                                 
      t.string :new_project
      # 4th new controller
      t.integer :new_rooms_count,                         default: 0      
      t.integer :total_rent_annual_estimations
      t.integer :month_count,                             default: 0
      t.integer :total_rent_monthly
      t.float :renta_brut
      t.float :renta_net

      t.references :user,                                 foreign_key: true, null: false
      
      t.timestamps
    end
  end
end
