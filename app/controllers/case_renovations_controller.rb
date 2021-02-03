class CaseRenovationsController < ApplicationController

  def new
    @case_renovations = CaseRenovation.new
    @s_button_submit = "Suivant"
    @s_title_document = "Etape 3/4"
  end

  def create
    @case_renovations = User.find(current_user.id).cases.new(cases_params)
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
end
