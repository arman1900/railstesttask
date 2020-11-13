class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to @user
        else
            flash[:notice] ="You successfully registered"
            render :new
        end
    end
    def new
        if signed_in?
            redirect_to root_path 
        end
        @user = User.new
    end
    def index
        @user = User.all
    end
    def show
        @user = User.find(params[:id])
        results = Geocoder.search(@user.location)
        @location = results.first
    end
    def edit
        @user=User.find(params[:id])
    end
    def update
        begin
            @user = User.find(params[:id])
        rescue
            flash[:error] = "User does not exixt"
        ensure 
            if @user.update_attributes(user_params)
                flash[:notice] = "You succesfully edited your profile"
            else
                render :new
            end
        end
    end
    private
    def user_params
		params.require(:user).permit(:avatar,:zip,:country,:city,:state,:role,:login,:name,:email, :password, :address,:password_confirmation,:birthday)
    end
end