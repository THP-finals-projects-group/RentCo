class CaseFeeAndChargesController < ApplicationController

  def new
    @case_fee_and_charges = CaseFeeAndCharge.new
    @s_button_submit = "Suivant"
    @s_title_document = "Etape 2/4"
  end

  def create
    @case_fee_and_charges = User.find(current_user.id).cases.new(cases_params)
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
