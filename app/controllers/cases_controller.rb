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

    def generate_pdf
        html = 
        pdf = WickedPdf.new.pdf_from_string(html)
        send_data pdf
        redirect_to cases_path
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

    def delete_video_attachment
        video = ActiveStorage::Attachment.find(params[:id])
        case_id = video.record_id
        video.purge
        respond_to do |format|
          format.html { redirect_to edit_case_path(case_id), notice: 'La vidéo à bien été supprimée' }
          format.json { head :no_content }
        end
    end

    private

        def set_case
            @case = Case.find(params[:id])
        end
    
        def cases_params
            if current_user.administrator?
                params.require(:case).permit(:title, :case_reference, :visit_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :renovation_union, :notary_charges, :heater_cost, :water_cost, :electricity_cost, :common_charges_cost, :agency_charges, :physical_description, :geographical_description, :potential_description, :renovation_demolition_cost, :renovation_preparation_cost, :renovation_carpentry_cost, :renovation_plastering_cost, :renovation_electricity_cost, :renovation_plumbing_cost, :renovation_wall_ceiling_cost, :renovation_painting_cost, :renovation_flooring_cost, :renovation_kitchen_cost, :renovation_furniture_cost, :renovation_facade_cost, :renovation_security_cost, :renovation_masonry_cost, :renovation_covering_cost, :new_type, :new_project, :new_surface, :new_rooms_count, :month_count, videos: [])
            else
                params.require(:case).permit(:title, :case_reference, :visit_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :renovation_union, :notary_charges, :heater_cost, :water_cost, :electricity_cost, :common_charges_cost, :agency_charges, :physical_description, :geographical_description, :potential_description, videos: [])
            end
        end

end
