class SessionsController < ApplicationController

    def new
    end
  
    def create
      @user = User.find_by(name: params[:user][:name])
      if @user
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else 
        redirect_to :new
      end
    
    end
  
    def destroy
      session.destroy
      redirect_to root_path
    end
end