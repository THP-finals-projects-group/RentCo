class CaseFeeAndCharge < ApplicationRecord
  belongs_to :case
  # Deuxième partie du formulaire
  validates :estimated_negociation, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :notary_charges, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :property_taxes, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :agency_charges, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_union, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  # monthly charges
  validates :total_monthly_charges, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :water_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :heater_cost,numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :electricity_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :union_charges_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :common_charges_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    
end
