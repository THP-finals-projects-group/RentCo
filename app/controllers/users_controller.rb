class  UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :update]

    def index
        if current_user.administrator?
            @users = User.where.not(role: 1).order(:approved, :updated_at, :created_at)
        else
            flash[:warning]="Vous n'avez pas accès à cette page"
            redirect_to root_path
        end
    end

    def show
        @users = User.all
        @cases = Case.where(user_id:@user.id)

        if current_user.administrator?
        elsif
            current_user.id == @user.id
        else
            flash[:warning]="Vous n'avez pas accès à cette page"
            redirect_to root_path
        end
    end

    def update
        if current_user.administrator?
            if @user.approved == false
                if @user.update(approved: true)
                    User.send_account_approval_mail(@user.email)
                    respond_to do |format|
                        format.html { redirect_to users_path, notice: 'Compte utilisateur confirmé !'}
                        format.js { }
                    end
                else
                    respond_to do |format|
                        format.html { redirect_to users_path, notice: 'Impossible de confirmer le compte !'}
                        format.js { }
                    end
                end
            else @user.approved == true
                if @user.update(approved: false)
                    User.send_account_blocked_mail(@user.email)
                    respond_to do |format|
                        format.html { redirect_to users_path, notice: 'Compte utilisateur desactivé !'}
                        format.js { }
                    end
                else
                    respond_to do |format|
                        format.html { redirect_to users_path, notice: 'Impossible de desactiver le compte !'}
                        format.js { }
                    end
                end
            end
        else
            flash.alert ="vous n'avez pas accès à cette commande"
        end
    end 

    private

        def set_user
            @user = User.find(params[:id])
        end

end
    