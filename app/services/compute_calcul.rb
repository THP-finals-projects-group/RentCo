class ComputeCalcul < ApplicationController

    def self.compute_user_part(id)
        @case = Case.find(id)

        # Calcul of charges and price
        @case.total_monthly_charges = @case.water_cost + @case.heater_cost + @case.electricity_cost + @case.union_charges_cost + @case.common_charges_cost
        @case.total_buying_price = @case.seller_price - @case.estimated_negociation + @case.notary_charges + @case.agency_charges + @case.property_taxes + @case.renovation_union
        self.calcul_confirmed = true
        @case.save
    end
    
    def self.compute_pre_estimation_renovation(id)
        # Calcul of the first estimation of renovation cost
        @case.pre_estimation_renovation_cost = @case.old_surface * @case.indicator_pre_estimation_renovation
        @case.save
    end

    def self.compute_finals_calculs(id)
        @case = Case.find(id)

        # Calcul of PNO assurance
        @case.pno_insurance_cost = @case.new_surface * 3.50

        # Calcul of the renovation cost
        @case.total_renovation_cost = @case.renovation_demolition_cost + @case.renovation_preparation_cost + @case.renovation_carpentry_cost + @case.renovation_plastering_cost + @case.renovation_electricity_cost + @case.renovation_plumbing_cost + @case.renovation_wall_ceiling_cost + @case.renovation_painting_cost + @case.renovation_flooring_cost + @case.renovation_kitchen_cost + @case.renovation_furniture_cost + @case.renovation_facade_cost + @case.renovation_security_cost + @case.renovation_masonry_cost + @case.renovation_covering_cost

        # Calcul of the rent_monthly rooms
        total_rent_rooms = 0
        @case.rooms.each do |room|
            total_rent_rooms = total_rent_rooms.to_i + room.rent_monthly.to_i
        end
        @case.total_rent_monthly = total_rent_rooms

        @case.total_rent_annual_estimations = @case.total_rent_monthly * @case.month_count
    
        # Calcul of rentabilities
        @case.renta_brut = (@case.total_rent_annual_estimations * 10).to_f / (@case.total_buying_price + @case.total_renovation_cost).to_f

        @case.renta_net = (@case.total_rent_annual_estimations - @case.property_taxes - @case.property_taxes).to_f / ((@case.total_buying_price + @case.total_renovation_cost) / 10).to_f
        @case.save
    end

end