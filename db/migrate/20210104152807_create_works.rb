class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.integer :pno_insurance_cost
      t.integer :total_renovation_cost
      t.integer :renovation_demolition_cost
      t.integer :renovation_preparation_cost
      t.integer :renovation_carpentry_cost
      t.integer :renovation_plastering_cost
      t.integer :renovation_electricity_cost
      t.integer :renovation_plumbing_cost
      t.integer :renovation_wall_ceiling_cost
      t.integer :renovation_painting_cost
      t.integer :renovation_flooring_cost
      t.integer :renovation_kitchen_cost
      t.integer :renovation_furniture_cost
      t.integer :renovation_facade_cost
      t.integer :renovation_security_cost
      t.integer :renovation_masonry_cost
      t.integer :renovation_covering_cost
      t.integer :new_surface
      t.string :new_type
      t.string :new_project

      t.timestamps
    end
  end
end
