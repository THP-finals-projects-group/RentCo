class CreateCaseRenovations < ActiveRecord::Migration[5.2]
  def change
    create_table :case_renovations do |t|

       # Troisième parite du formulaire
      # renovation
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
      t.integer :new_rooms_count,                         default: 0 
      t.string :new_type                                 
      t.string :new_project

      t.references :case,      foreign_key: true
      
      t.timestamps
    end
  end
end
