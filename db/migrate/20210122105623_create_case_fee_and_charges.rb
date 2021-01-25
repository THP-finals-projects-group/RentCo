class CreateCaseFeeAndCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :case_fee_and_charges do |t|

      # Deuxième partie du formulaire
      t.integer :estimated_negociation,                   default: 0
      t.integer :notary_charges,                          default: 0
      t.integer :property_taxes,                          default: 0
      t.integer :agency_charges,                          default: 0
      t.integer :renovation_union,                        default: 0
      # monthly charges
      t.integer :total_monthly_charges
      t.integer :water_cost,                              default: 0
      t.integer :heater_cost,                             default: 0
      t.integer :electricity_cost,                        default: 0
      t.integer :union_charges_cost,                      default: 0
      t.integer :common_charges_cost,                     default: 0

      t.references :case,      foreign_key: true
      
      t.timestamps
    end
  end
end
