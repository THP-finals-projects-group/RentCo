class CasesController < ApplicationController
    before_action :set_case, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

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
	end

    def new
        @case = Case.new
    end

    def create
        @case = Case.new(cases_params)

        if @case.save 
            redirect_to root_path, notice: 'Votre dossier à bien été ouvert.'
        else 
            flash.now[:alert] = "Le dossier n'a pas pu être enregistré : #{@case.errors.messages}"
            render 'new'
        end
    end

    def edit 
        @case = Case.find(params[:id])
    end

    def update 
        @case = Case.find(params[:id])
        @case.update(cases_params)
        redirect_to root_path
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
                params.require(:case).permit(:title, :case_reference, :visited_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :renovation_union, :notary_charges,    :water_cost, :electricity_cost, :common_charges_cost,      :physical_description, :geographical_description, :potential_description, :renovation_demolition_cost, :renovation_preparation_cost, :renovation_carpentry_cost, :renovation_plastering_cost, :renovation_electricity_cost, :renovation_plumbing_cost, :renovation_wall_ceiling_cost, :renovation_painting_cost, :renovation_flooring_cost, :renovation_kitchen_cost, :renovation_furniture_cost, :renovation_facade_cost, :renovation_security_cost, :renovation_masonry_cost, :renovation_covering_cost, :new_type, :new_project, :new_surface, :new_rooms_count, :month_count)
            else
                params.require(:case).permit(:title, :case_reference, :visited_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :renovation_union, :notary_charges,    :water_cost, :electricity_cost, :common_charges_cost,      :physical_description, :geographical_description, :potential_description)
            end
        end

end
