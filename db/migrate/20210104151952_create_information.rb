class CreateInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :information do |t|
      t.string :title
      t.string :case_reference
      t.text :contact_referent
      t.string :street_number
      t.string :street_name
      t.string :city
      t.string :zipcode
      t.float :longitude
      t.float :latitude
      t.datetime :visit_date
      t.boolean :is_confirmed
      t.text :physical_description
      t.text :geographical_description
      t.text :potential_description
      t.integer :old_surface
      t.integer :old_rooms_count
      t.string :old_type
      t.string :old_project

      t.timestamps
    end
  end
end
