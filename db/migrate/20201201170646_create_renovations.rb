class CreateRenovations < ActiveRecord::Migration[5.2]
  def change
    create_table :renovations do |t|
      t.integer :total_renovation_cost
      t.integer :demolition_cost
      t.integer :preparation_cost
      t.integer :carpentry_cost
      t.integer :plastering_cost
      t.integer :electricity_cost
      t.integer :plumbing_cost
      t.integer :wall_ceiling_cost
      t.integer :painting_cost
      t.integer :flooring_cost
      t.integer :kitchen_cost
      t.integer :furniture_cost
      t.integer :facade_cost
      t.integer :security_cost
      t.integer :masonry_cost
      t.integer :covering_cost

      t.timestamps
    end
  end
end
