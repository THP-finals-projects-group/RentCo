class CreateCaseComputeCalculs < ActiveRecord::Migration[5.2]
  def change
    create_table :case_compute_calculs do |t|

      # Quatrième partie du formulaire
      t.integer :total_rent_annual_estimations
      t.integer :month_count,                             default: 0
      t.integer :total_rent_monthly
      t.float :renta_brut
      t.float :renta_net

      t.references :case,      foreign_key: true
      
      t.timestamps
    end
  end
end
