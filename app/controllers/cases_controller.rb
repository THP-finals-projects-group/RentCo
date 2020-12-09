class CasesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_case, only: [:show, :edit, :update, :destroy, :generate_pdf]
    

    def index     

		if current_user.administrator?
			@cases = Case.all.order(:updated_at, :created_at).reverse
		else
			@cases = Case.where(user_id:current_user.id)
        end
	end

	def show
        @case = Case.find(params[:id])
        @user = User.find(@case.user_id)
    end

    def generate_pdf
        html = render_to_string(partial: "cases/case.pdf.erb")
        pdf = WickedPdf.new.pdf_from_string(html, title: "#{@case.id}_dossier")
        send_data pdf, filename: "#{@case.id}_dossier"
    end

    def generate_compute
        ComputeCalcul.compute_finals_calculs(params[:id])
        redirect_to case_path(params[:id])
    end

    def new
        @case = Case.new
        @case.rooms.new
        @s_button_submit = "Créer le dossier"
        @s_title_document = "Création d'un nouveau dossier"
    end

    def create   
        @case = User.find(current_user.id).cases.new(cases_params)
        if current_user.administrator?
            @case.save
            rooms = params[:case][:rooms_attributes]
            rooms.each do |hash|
                (hash[1].values_at("_destroy")[0] == "false" && !(hash[1].values_at("rent_monthly")[0] == "0")) ? rent = hash[1].values_at("rent_monthly")[0] : next 
                @case.rooms.create!(rent_monthly: rent.to_i)
            end
            @case.new_rooms_count = @case.rooms.length
        end
        if @case.save
            if current_user.administrator?
                flash[:success] = 'Votre dossier à bien été créé.'
                redirect_to case_path(@case.id)
            else
                flash[:success] = 'Votre dossier à bien été ouvert.'
                redirect_to case_path(@case.id)
            end
        else 
            flash.now[:alert] = "Le dossier n'a pas pu être enregistré : #{@case.errors.messages}"
            render 'new'
        end

        
    end

    def edit 
        @case = Case.find(params[:id])
        if (current_user.user? && @case.is_confirmed == false) || current_user.administrator?
            @s_button_submit = "Modifier dossier"
            @s_title_document = "Modification du dossier"
        else
            flash[:warning] =  "Vous n'êtes pas autorisé à modifier le dossier !"
            redirect_to root_path
        end
    end

    def update 
        @case = Case.find(params[:id])
        if current_user.administrator? 
            @case.update(cases_params)
            @case.rooms.destroy_all
            rooms = params[:case][:rooms_attributes]
            rooms.each do |hash|
                (hash[1].values_at("_destroy")[0] == "false" && !(hash[1].values_at("rent_monthly")[0] == "0")) ? rent = hash[1].values_at("rent_monthly")[0] : next 
                @case.rooms.create!(rent_monthly: rent.to_i)
            end
            @case.new_rooms_count = @case.rooms.length
            @case.save
            flash[:success] =  "Le dossier à était mis à jour!"
            redirect_to case_path(@case.id)
        else
            @case.update(cases_params)
            flash[:success] =  "Le dossier à était mis à jour!"
            redirect_to case_path(@case.id)
        end
    end

    def toogle_is_confirmed
        @case = Case.find(params[:id])
        if @case.is_confirmed == false
            @case.update(is_confirmed: true)
            respond_to do |format|
                format.html { redirect_to cases_path, notice: 'Le dossier a bien été fermé' }
                format.json { head :no_content }
            end
        else
            @case.update(is_confirmed: false)
            respond_to do |format|
                format.html { redirect_to cases_path, notice: 'Le dossier a bien été fermé' }
                format.json { head :no_content }
            end
        end
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
          format.html { redirect_to URI(request.referrer).path, notice: 'La vidéo à bien été supprimée' }
          format.json { head :no_content }
        end
    end

    private

        def set_case
            @case = Case.find(params[:id])
        end
    
        def cases_params
            if current_user.administrator?
                params.require(:case).permit( :is_confirmed, :title, :case_reference, :visit_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :renovation_union, :notary_charges, :union_charges_cost, :heater_cost, :water_cost, :electricity_cost, :common_charges_cost, :agency_charges, :physical_description, :geographical_description, :potential_description, :renovation_demolition_cost, :renovation_preparation_cost, :renovation_carpentry_cost, :renovation_plastering_cost, :renovation_electricity_cost, :renovation_plumbing_cost, :renovation_wall_ceiling_cost, :renovation_painting_cost, :renovation_flooring_cost, :renovation_kitchen_cost, :renovation_furniture_cost, :renovation_facade_cost, :renovation_security_cost, :renovation_masonry_cost, :renovation_covering_cost, :new_type, :new_project, :new_surface, :new_rooms_count, :month_count, videos: [])
            else
                params.require(:case).permit(:title, :case_reference, :visit_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :renovation_union, :notary_charges, :union_charges_cost, :heater_cost, :water_cost, :electricity_cost, :common_charges_cost, :agency_charges, :physical_description, :geographical_description, :potential_description, videos: [])
            end
        end
        # :rooms_attributes [[]=>["rent_monthly", "_destroy"]],
        # def params_rooms(c)
        #     c.rooms.each do |room_completed|
        #         room_completed.destroy
        #     end
        #     rooms = params[:case][:rooms_attributes]
        #     rooms.each do |hash|
        #         hash[1].values_at("rent_monthly").empty? ? rent = hash[1].values_at("rent_monthly") : next
        #         c.rooms.new(rent_monthly: rent.to_i)
        #     end
        #     c
        # end

end
