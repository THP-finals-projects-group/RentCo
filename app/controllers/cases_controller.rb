class  CasesController < ApplicationController
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

    private
        def cases_params
            params.require(:case).permit(videos: [])
        end
end
    