class CreateRenovations < ActiveRecord::Migration[5.2]
  def change
    create_table :renovations do |t|
      t.int :total_renovation_cost
      t.int :demolition_cost
      t.int :preparation_cost
      t.int :carpentry_cost
      t.int :plastering_cost
      t.int :electricity_cost
      t.int :plumbing_cost
      t.int :wall_ceiling_cost
      t.int :painting_cost
      t.int :flooring_cost
      t.int :kitchen_cost
      t.int :furniture_cost
      t.int :facade_cost
      t.int :security_cost
      t.int :masonry_cost
      t.int :covering_cost

      t.timestamps
    end
  end
end
