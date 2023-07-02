class UsersController < ApplicationController
    def create
      user = User.new(user_params)
  
      if user.save
        session[:user_id] = user.id
        render json: user
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      user = current_user
  
      if user
        render json: user
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :password)
    end
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  