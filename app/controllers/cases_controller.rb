class  CasesController < ApplicationController

    private
        def cases_params
            params.require(:case).permit(images: [])
        end
end
    