class SessionsController < ApplicationController
    def new

    end
    def create
        login = params[:session][:login]
            if login.include? "@"
                user=User.find_by_email(login) 
            else 
                user=User.find_by_login(login)
                puts user.login
            end
            if user && user.authenticate(params[:session][:password])
                sign_in user
                redirect_to user
            else
                flash[:error] = "Invaild username or email"
                render "new"
            end
    end
def destroy
        sign_out
        redirect_to root_path
end 
def show
    if current_user
        render json: current_user
    else
        flash[:error] = "Not signed in"
    end
end 
end
