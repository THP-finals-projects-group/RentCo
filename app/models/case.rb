class Case < ApplicationRecord
    # DB RELATIONS
    has_one                 :user
    has_many                :rooms, dependent: :destroy
    accepts_nested_attributes_for :rooms, allow_destroy: true

    # ACTIVE STORAGE
    has_many_attached       :videos

    after_create :mailer_new_case

    # GEO CODER
    geocoded_by :address
    after_validation :geocode, if: :address_changed?

    # COMPUTE CALCUL
    before_save :compute_calculs

    # VALIDATES
    validates :title, presence: true, length: { minimum: 5, maximum: 140}
    validates :case_reference, presence: true, length: { minimum: 2 }
    validates :contact_referent, allow_blank: true, length: { minimum: 0, maximum: 500 }
    validates :street_number, presence: true, length: { minimum: 1, maximum: 10 }
    validates :street_name, presence: true, length: { minimum: 3, maximum: 140 }
    validates :city, presence: true, length: { minimum: 3, maximum: 140 }
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
    # monthly charges
    validates :total_monthly_charges, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :water_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :heater_cost,numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :electricity_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :union_charges_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :common_charges_cost, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    # buying price
    validates :total_buying_price, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :seller_price, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :estimated_negociation, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :notary_charges, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :property_taxes, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :agency_charges, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :renovation_union, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
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
    validates_presence_of :rooms, message: "can't be null"
    validates :total_rent_annual_estimations, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    validates :month_count, numericality: { length: {in: 1...12} , only_integer: true, allow_blank: true}
    validates :total_rent_monthly, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    # validates :renta_brut, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    # validates :renta_net, numericality: {greater_than_or_equal_to: 0, allow_blank: true}
    # videos
    # validates :videos, presence: true, blob: { content_type: ['video/mp4', 'video/avi'], size_range: 1..20.megabytes }


    private
  
    def past_date
      errors.add(:visit_date, "Vous ne pouvez rentrer une date future") unless
        visit_date <= DateTime.now - 1.hour
    end

    def mailer_new_case
        AdminMailer.new_case(self).deliver_now
    end

    # Methods for GeoCoder
    def address
        [street_number, street_name, zipcode, city].compact.join(",")
    end

    def address_changed?
        street_number? || street_name? || zipcode? || city?
    end

    def compute_calculs
        # Calcul of charges and price
        self.total_monthly_charges = self.water_cost + self.heater_cost + self.electricity_cost + self.union_charges_cost + self.common_charges_cost
        self.total_buying_price = self.seller_price - self.estimated_negociation + self.notary_charges + self.agency_charges + self.property_taxes + self.renovation_union

        if User.find(self.user_id).administrator?
            self.pre_estimation_renovation_cost = self.old_surface * self.indicator_pre_estimation_renovation
    
            # Calcul of PNO assurance
            self.pno_insurance_cost = self.new_surface * 3.50
    
            # Calcul of the renovation cost
            self.total_renovation_cost = self.renovation_demolition_cost + self.renovation_preparation_cost + self.renovation_carpentry_cost + self.renovation_plastering_cost + self.renovation_electricity_cost + self.renovation_plumbing_cost + self.renovation_wall_ceiling_cost + self.renovation_painting_cost + self.renovation_flooring_cost + self.renovation_kitchen_cost + self.renovation_furniture_cost + self.renovation_facade_cost + self.renovation_security_cost + self.renovation_masonry_cost + self.renovation_covering_cost
    
            # Calcul of the rent_monthly rooms
            total_rent_rooms = 0
            self.rooms.each do |room|
                total_rent_rooms = total_rent_rooms.to_i + room.rent_monthly.to_i
            end
            self.total_rent_monthly = total_rent_rooms
    
            self.total_rent_annual_estimations = self.total_rent_monthly * self.month_count
        
            # Calcul of rentabilities
            self.renta_brut = (self.total_rent_annual_estimations * 10).to_f / (self.total_buying_price + self.total_renovation_cost).to_f
    
            self.renta_net = (self.total_rent_annual_estimations - self.property_taxes - self.property_taxes).to_f / ((self.total_buying_price + self.total_renovation_cost) / 10).to_f
        end
    end

end
