class CreateCaseMainInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :case_main_informations do |t|

      # Première partie du formulaire 
      t.string :title,                                   unique: true, null: false
      t.string :city,                                    null: false
      t.string :case_reference,                          null: false
      t.text :contact_referent,                          null: false, default: "Matthieu Gilette"
      t.string :street_number,                           null: false
      t.string :street_name,                             null: false 
      t.string :zipcode,                                 null: false, limit: 5
      t.float :longitude
      t.float :latitude
      t.datetime :visit_date,                            null: false     
      t.text :physical_description,                      limit: 500
      t.text :geographical_description,                  limit: 500
      t.text :potential_description,                     limit: 500

      # old_information
      t.integer :old_surface,                             null: false, default: 0
      t.integer :old_rooms_count,                         null: false, default: 0
      t.string :old_type,                                 null: false
      t.string :old_project,                              null: false
      
      # BELOW ADMIN PART // ABOVE USER PART
      t.string :hunter
      # buying price
      t.integer :total_buying_price
      t.integer :seller_price,                            default: 0

      t.references :case,      foreign_key: true
      
      t.timestamps
    end
  end
end
