class RoomsController < ApplicationController

    def edit
        @case_rooms = Room.where(case_id: params[:id])
    end

    def update 
        
        @case_rooms = Room.where(case_id: params[:id])
        @case_rooms.each do |room| 
            room.update(rent_monthly: params[room.rent_monthly.to_s].to_i)
        end 

        redirect_to case_path(@case_rooms[0].case_id)
    end

end