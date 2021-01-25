class CaseMainInformation < ApplicationRecord
  belongs_to :case
  #Première partie du formulaire 
  # VALIDATES
  
  validates :case_reference, presence: true, length: { minimum: 2 }
  validates :contact_referent, allow_blank: true, length: { minimum: 0, maximum: 500 }
  validates :street_number, presence: true, length: { minimum: 1, maximum: 10 }
  validates :street_name, presence: true, length: { minimum: 3, maximum: 140 }

  validates :zipcode, presence: true, format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "is not a valid french zipcode" }
  validates :visit_date, presence: true #, if: :past_date
  validates :physical_description, length: {in: 3...500}, allow_blank: true
  validates :geographical_description, length: {in: 3...500}, allow_blank: true
  validates :potential_description, length: {in: 3...500}, allow_blank: true
  # old_information
  validates :old_surface, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :old_rooms_count, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :old_type, presence: true
  validates :old_project, presence: true
  # BELOW ADMIN PART // ABOVE USER PART
  # buying price
  validates :total_buying_price, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
  validates :seller_price, numericality: {greater_than_or_equal_to: 0, allow_blank: true}

end
