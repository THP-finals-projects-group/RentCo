class CreateRenovations < ActiveRecord::Migration[5.2]
  def change
    create_table :renovations do |t|
      t.integer :total_renovation_cost
      t.integer :demolition_cost,       default: 0
      t.integer :preparation_cost,      default: 0
      t.integer :carpentry_cost,        default: 0
      t.integer :plastering_cost,       default: 0
      t.integer :electricity_cost,      default: 0
      t.integer :plumbing_cost,         default: 0
      t.integer :wall_ceiling_cost,     default: 0
      t.integer :painting_cost,         default: 0
      t.integer :flooring_cost,         default: 0
      t.integer :kitchen_cost,          default: 0
      t.integer :furniture_cost,        default: 0
      t.integer :facade_cost,           default: 0
      t.integer :security_cost,         default: 0
      t.integer :masonry_cost,          default: 0
      t.integer :covering_cost,         default: 0

      t.timestamps
    end
  end
end
