class CasesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_case, only: [:show, :edit, :update, :destroy, :generate_pdf]
    
    def index     
		if current_user.administrator?
            @cases = Case.all.order(:updated_at, :created_at).reverse
            @users = User.all
		else
			@cases = Case.where(user_id:current_user.id)
        end
	end

	def show
        @case = Case.find(params[:id])
        @user = User.find(@case.user_id)
    end

    def new
        @case = Case.new
        @case.rooms.new
        @s_button_submit = "Créer le dossier"
        @s_title_document = "Création d'un nouveau dossier"
    end

    def create
        @case = User.find(current_user.id).cases.new(cases_params)
        @case.rooms.new(rent_monthly: 0)
        if @case.save
            if current_user.administrator?
                rooms_create(params[:case])
            end
            flash[:success] = 'Votre dossier a bien été ouvert.'
            redirect_to case_path(@case.id)
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
        @case.update(cases_params)
        if current_user.administrator? 
            rooms_create(params[:case])
        end
        flash[:success] =  "Le dossier | #{@case.title} | a été mis à jour, le pdf est désormais disponible en bas de la page !"
        redirect_to case_path(@case.id)
    end

    def destroy 
        @case.destroy
        respond_to do |format|
          format.html { redirect_to cases_url, flash: {danger: "Le dossier | #{@case.title} | a bien été supprimé" } }
          format.json { head :no_content }
        end
    end

    def delete_video_attachment
        video = ActiveStorage::Attachment.find(params[:id])
        case_id = video.record_id
        video.purge
        respond_to do |format|
          format.html { redirect_to URI(request.referrer).path, flash: {danger: 'La video a bien été supprimé' } }
          format.json { head :no_content }
        end
    end

    def toogle_is_confirmed
        @case = Case.find(params[:id])
        @user = User.find(@case.user_id)
        if @case.is_confirmed == false
            @case.update(is_confirmed: true)
            User.send_case_confirmed_mail(@case)
            respond_to do |format|
                format.html { redirect_to cases_path, flash: {success: "Le dossier | #{@case.title} | a bien été validé, le collaborateur en charge du dossier ne peut plus apporter de modifications. Il à été prévenu par email"} }
                format.json { head :no_content }
            end
        else
            @case.update(is_confirmed: false)
            respond_to do |format|
                format.html { redirect_to cases_path, flash: {info: "Le dossier | #{@case.title} | est maintenant modifiable par vous et le collaborateur en charge du dossier"} }
                format.json { head :no_content }
            end
        end
    end

    def generate_pdf
        html = render_to_string(partial: "cases/case.pdf.erb")
        pdf = WickedPdf.new.pdf_from_string(html, title: "#{@case.id}_dossier")
        send_data pdf, filename: "#{@case.id}_dossier.pdf"
    end

    private

    def set_case
        @case = Case.find(params[:id])
    end

    def cases_params
        if current_user.administrator?
            params.require(:case).permit( :is_confirmed, :title, :case_reference, :visit_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :renovation_union, :notary_charges, :union_charges_cost, :heater_cost, :water_cost, :electricity_cost, :common_charges_cost, :agency_charges, :physical_description, :geographical_description, :potential_description, :indicator_pre_estimation_renovation, :renovation_demolition_cost, :renovation_preparation_cost, :renovation_carpentry_cost, :renovation_plastering_cost, :renovation_electricity_cost, :renovation_plumbing_cost, :renovation_wall_ceiling_cost, :renovation_painting_cost, :renovation_flooring_cost, :renovation_kitchen_cost, :renovation_furniture_cost, :renovation_facade_cost, :renovation_security_cost, :renovation_masonry_cost, :renovation_covering_cost, :new_type, :new_project, :new_surface, :new_rooms_count, :month_count, videos: [])
        else
            params.require(:case).permit(:title, :case_reference, :visit_date, :street_number, :street_name, :city, :zipcode, :old_project, :old_surface, :old_type, :old_rooms_count, :seller_price, :estimated_negociation, :property_taxes, :renovation_union, :notary_charges, :union_charges_cost, :heater_cost, :water_cost, :electricity_cost, :common_charges_cost, :agency_charges, :physical_description, :geographical_description, :potential_description, videos: [])
        end
    end

    def rooms_create(params)
        rooms_attribute = params[:rooms_attributes]
        if !(rooms_attribute.nil?)
            @case.rooms.destroy_all
            rooms_attribute.each do |hash|
                if hash[1].values_at("rent_monthly")[0] == "0" && hash[1].values_at("_destroy")[0] == "1"
                    @case.rooms.create!(rent_monthly: 0)
                elsif hash[1].values_at("_destroy")[0] == "false" && (!(hash[1].values_at("rent_monthly")[0].empty?) || !(hash[1].values_at("rent_monthly")[0] == "0"))
                    rent = hash[1].values_at("rent_monthly")[0]
                    @case.rooms.create!(rent_monthly: rent.to_i) 
                else
                    next
                end
            end
        else
            @case.rooms.create(rent_monthly: 0)
        end
        @case.new_rooms_count = @case.rooms.length
        @case.save
    end

end
