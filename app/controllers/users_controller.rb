class UsersController < ApplicationController
    def new
      @user = User.new
    end
    
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to "/", user_name: @user.email
      else
        redirect_to "/register", user_name: @user.email
      end
    end

    def login
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
  end
  