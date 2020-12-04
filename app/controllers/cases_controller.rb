class CasesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_case, only: [:show, :edit, :update, :destroy]
    

    def index
		@user = current_user
		if @user.administrator?
			@cases = Case.all
		else
			@cases = Case.where(user_id:@user.id)
		end
	end

	def show
        @case = Case.find(params[:id])
        @user = User.find(@case.user_id)

        # Calcul charges et prix du bien
        @case.total_monthly_charges = @case.water_cost + @case.heater_cost + @case.electricity_cost + @case.union_charges_cost + @case.common_charges_cost
        @case.total_buying_price = @case.seller_price - @case.estimated_negociation + @case.notary_charges + @case.agency_charges + @case.property_taxes # + @case.renovation_union

        # Calcul assurance PNO
        @case.pno_insurance_cost = @case.new_surface * 3.50

        #Calcul des travaux
        @case.total_renovation_cost = @case.renovation_demolition_cost + @case.renovation_preparation_cost + @case.renovation_carpentry_cost + @case.renovation_plastering_cost + @case.renovation_electricity_cost + @case.renovation_plumbing_cost + @case.renovation_wall_ceiling_cost + @case.renovation_painting_cost + @case.renovation_flooring_cost + @case.renovation_kitchen_cost + @case.renovation_furniture_cost + @case.renovation_facade_cost + @case.renovation_security_cost + @case.renovation_masonry_cost + @case.renovation_covering_cost

        # Calcul après avoir complété le coût des chambres
        total_rent_rooms = 0
        @case.rooms.each do |room|
            total_rent_rooms = total_rent_rooms + room.rent_monthly
        end
        @case.total_rent_monthly = total_rent_rooms

        @case.total_rent_annual_estimations = @case.total_rent_monthly * @case.month_count

        # Calcul de rentabilité
        @case.renta_brut = (@case.total_rent_annual_estimations * 10) / (@case.total_buying_price + @case.total_renovation_cost)

        @case.renta_net = (@case.total_rent_annual_estimations - @case.total_buying_price - @case.pno_insurance_cost) / ((@case.total_buying_price + @case.total_renovation_cost) / 10)
	end

    def new
        @case = Case.new
        @s_button_submit = "Créer dossier"
    end

    def create
        @case = User.find(current_user.id).cases.new(cases_params)

        if @case.save 
            redirect_to root_path, notice: 'Votre dossier à bien été ouvert.'
        else 
            flash.now[:alert] = "Le dossier n'a pas pu être enregistré : #{@case.errors.messages}"
            render 'new'
        end

    end

    def edit 
        @case = Case.find(params[:id])
        @s_button_submit = "Modifier dossier"
    end

    def update 
        @case = Case.find(params[:id])
        @case.rooms.each do |room_completed|
            room_completed.destroy
        end
        @case.update(cases_params)
        @case.new_rooms_count.times do |room|
            Room.create(case_id: @case.id)
        end

        redirect_to root_path
    end

    def destroy 
        @case.destroy
        respond_to do |format|
          format.html { redirect_to cases_url, notice: 'Le dossier a bien été supprimé' }
          format.json { head :no_content }
        end
    end

    private
        def cases_params
            params.require(:case).permit(videos: [])
        end

        def set_case
            @case = Case.find(params[:id])
        end
    
        def cases_params
            if current_user.administrator?
                params.require(:case).permit(:title, :case_reference, :visit_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :union_charges_cost, :notary_charges, :heater_cost, :water_cost, :electricity_cost, :common_charges_cost, :agency_charges, :physical_description, :geographical_description, :potential_description, :renovation_demolition_cost, :renovation_preparation_cost, :renovation_carpentry_cost, :renovation_plastering_cost, :renovation_electricity_cost, :renovation_plumbing_cost, :renovation_wall_ceiling_cost, :renovation_painting_cost, :renovation_flooring_cost, :renovation_kitchen_cost, :renovation_furniture_cost, :renovation_facade_cost, :renovation_security_cost, :renovation_masonry_cost, :renovation_covering_cost, :new_type, :new_project, :new_surface, :new_rooms_count, :month_count)
            else
                params.require(:case).permit(:title, :case_reference, :visit_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :union_charges_cost, :notary_charges, :heater_cost, :water_cost, :electricity_cost, :common_charges_cost, :agency_charges, :physical_description, :geographical_description, :potential_description)
            end
        end

end
