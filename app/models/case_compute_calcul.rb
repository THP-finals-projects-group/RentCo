class CaseComputeCalcul < ApplicationRecord
  belongs_to :case
  # Quatrième partie du formulaire
  validates :total_rent_annual_estimations, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :month_count, numericality: { length: {in: 1...12} , only_integer: true, allow_blank: true}
  validates :total_rent_monthly, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  # validates :renta_brut, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  # validates :renta_net, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  # videos
  # validates :videos, presence: true, blob: { content_type: ['video/mp4', 'video/avi'], size_range: 1..20.megabytes }
  
end
