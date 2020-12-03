class CasesController < ApplicationController
    before_action :set_case, only: [:show, :edit, :update, :destroy]

    def new
        @case = Case.new
    end

    def create
    end

    private
    def cases_params
        params.require(:case).permit(images: [])
    end

    def set_case
        @case = Case.find(params[:id])
    end

    def cases_params
        if current_user.administrator?
            params.require(:case).permit(:title, :case_reference, :visited_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :renovation_union, :notary_charges,    :water_cost, :electricity_cost, :common_charges_cost,      :physical_description, :geographical_description, :potential_description)
        else
            params.require(:case).permit(:title, :case_reference, :visited_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :renovation_union, :notary_charges,    :water_cost, :electricity_cost, :common_charges_cost,      :physical_description, :geographical_description, :potential_description)
        end
    end

end
