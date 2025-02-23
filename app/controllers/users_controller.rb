class UsersController < ApplicationController
    before_action :require_login
  skip_before_action :require_login, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user   
        else
            render 'new'       
        end     
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def ride
      @ride = Ride.new(user_id: current_user.id, attraction_id: params[:format])
      message = @ride.take_ride
      redirect_to user_path(current_user), flash: { message: message }
    end

    private
 
    def user_params
      params.require(:user).permit(:name, :password, :height, :happiness, :nausea, :tickets, :admin)
    end

 
    def require_login
      redirect_to :root unless session.include? :user_id
    end


end