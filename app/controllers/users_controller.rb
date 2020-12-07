class  UsersController < ApplicationController
    before_action :set_user, only: [:show, :update]
    before_action :authenticate_user!

    def index
        if current_user.administrator?
            @users = User.all.order(approved: :asc)
        else
            redirect_to root_path
        end
    end

    def show
        if current_user.administrator?
        elsif
            current_user.id == @user.id
        else
            redirect_to root_path
            flash.alert ="Vous n'avez pas accès à cette page"
        end
    end

    def update
       
        if @user.update(approved: true)
            User.send_account_approval_mail(@user.email)
            respond_to do |format|
                format.html { redirect_to users_path, notice: 'Compte utilisateur confirmé'}
                format.js { }
            end
        else
            respond_to do |format|
                format.html { redirect_to users_path, notice: 'Impossible de confirmer le compte'}
                format.js { }
            end
        end
    end

    private

        def set_user
            @user = User.find(params[:id])
        end
end
    