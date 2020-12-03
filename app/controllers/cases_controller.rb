class CasesController < ApplicationController
    before_action: new edit

    def new
        @case = Case.new
    end

    def create
    end

    private
    def cases_params
        params.require(:case).permit(images: [])
    end

end
