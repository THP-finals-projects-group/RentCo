class Case < ApplicationRecord

	# DB RELATIONS
	has_many                        :users
	has_many                        :rooms, dependent: :destroy
	has_one                         :case_main_information
	has_one                         :case_fee_and_charge
	has_one                         :case_renovation
	has_one                         :case_compute_calcul
	accepts_nested_attributes_for   :rooms, allow_destroy: true

	# ACTIVE STORAGE
	has_many_attached               :videos

	# MAILER
	# after_create                    :mailer_new_case

	# GEO CODER
	geocoded_by                     :address
	# after_validation                :geocode, if: :address_changed?

	# COMPUTE CALCUL
	# before_save                     :compute_calculs

	validates :title, presence: true, length: { minimum: 5, maximum: 140}
	validates :city, presence: true, length: { minimum: 3, maximum: 140 }


	private

	def past_date
		errors.add(:visit_date, "Vous ne pouvez rentrer une date future") unless
		visit_date <= DateTime.now - 1.hour
	end

	# def mailer_new_case
	# 	AdminMailer.new_case(self).deliver_now
	# end

	# Methods for GeoCoder
	def address
		[street_number, street_name, zipcode, city].compact.join(",")
	end

	# def address_changed?
	# 	street_number? || street_name? || zipcode? || city?
	# end

	# def compute_calculs
	# 	# Calcul of charges and price
	# 	self.total_monthly_charges = self.water_cost + self.heater_cost + self.electricity_cost + self.union_charges_cost + self.common_charges_cost
	# 	self.total_buying_price = self.seller_price - self.estimated_negociation + self.notary_charges + self.agency_charges + self.property_taxes + self.renovation_union


	# 	if self.indicator_pre_estimation_renovation != nil
	# 		self.pre_estimation_renovation_cost = self.old_surface * self.indicator_pre_estimation_renovation
	# 	end

	# 	# Calcul of PNO assurance
	# 	self.pno_insurance_cost = self.new_surface * 3.50

	# 	# Calcul of the renovation cost
	# 	self.total_renovation_cost = self.renovation_demolition_cost + self.renovation_preparation_cost + self.renovation_carpentry_cost + self.renovation_plastering_cost + self.renovation_electricity_cost + self.renovation_plumbing_cost + self.renovation_wall_ceiling_cost + self.renovation_painting_cost + self.renovation_flooring_cost + self.renovation_kitchen_cost + self.renovation_furniture_cost + self.renovation_facade_cost + self.renovation_security_cost + self.renovation_masonry_cost + self.renovation_covering_cost

	# 	# Calcul of the rent_monthly rooms
	# 	total_rent_rooms = 0
	# 	self.rooms.each do |room|
	# 		total_rent_rooms = total_rent_rooms.to_i + room.rent_monthly.to_i
	# 	end
	# 	self.total_rent_monthly = total_rent_rooms

	# 	self.total_rent_annual_estimations = self.total_rent_monthly * self.month_count

	# 	# Calcul of rentabilities
	# 	if self.total_rent_annual_estimations > 0 && self.total_buying_price != nil
	# 		self.renta_brut = (self.total_rent_annual_estimations * 10).to_f / (self.total_buying_price + self.total_renovation_cost).to_f

	# 		self.renta_net = (self.total_rent_annual_estimations - self.property_taxes - self.property_taxes).to_f / ((self.total_buying_price + self.total_renovation_cost) / 10).to_f
		
	# 	end

	# end

end
