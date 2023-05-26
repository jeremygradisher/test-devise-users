class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :authorize_user!, only: [:destroy]
  
    def index
      @users = User.all
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @user = User.find(params[:id])
      respond_to do |format|
        if @user.destroy
          redirect_to users_url, notice: 'User was successfully destroyed.'
        else
          redirect_to users_url, alert: 'Failed to destroy user.'
        end
      end
    end

    def delete_avatar
      @user = User.find(params[:id])
      @user.avatar.purge
      redirect_to @user, notice: 'Avatar was successfully deleted.'
    end
  
    private
      def set_user
        @user = User.find(params[:id])
      end

      def authorize_user!
        unless current_user.is_admin? || current_user == @user
          redirect_to root_path, alert: "You are not authorized to perform this action."
        end
      end
  
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :is_admin, :avatar)
      end
  end
  