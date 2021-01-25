class CaseRenovation < ApplicationRecord
  belongs_to :case
  # Troisième parite du formulaire
  # renovation
  validates :indicator_pre_estimation_renovation, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :pno_insurance_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :total_renovation_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_demolition_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_preparation_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_carpentry_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_plastering_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_electricity_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_plumbing_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_wall_ceiling_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_painting_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_flooring_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_kitchen_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_furniture_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_facade_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_security_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_masonry_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :renovation_covering_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  # new_information
  validates :new_surface, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :new_rooms_count, numericality: {greater_than_or_equal_to: 0, only_integer: true, allow_blank: true}
  # validates :new_type, allow_blank: true
  # validates :new_project, allow_blank: true
  # validates_presence_of :rooms, message: "can't be null"
  
end
