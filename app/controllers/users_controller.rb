class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
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
      @user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
    end
  
    private
      def set_user
        @user = User.find(params[:id])
      end
  
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :is_admin)
      end
  end
  