class RoomsController < ApplicationController
    before_action :authenticate_user!

    def edit
        @case = Case.find(params[:id])
        @rooms = @case.rooms
        @case_rooms = Room.where(case_id: params[:id])
    end

    def update 
        
        @case_rooms = Room.where(case_id: params[:id])
        @case_rooms.each do |room| 
            room.update(rent_monthly: params[room.rent_monthly.to_s].to_i)
        end 

        ComputeCalcul.compute_finals_calculs(params[:id])
        redirect_to case_path(params[:id])
    end
end