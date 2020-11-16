class InvitationsController < ApplicationController
    def create
        if is_client? 
            @user = User.find(params[:id])
            if current_user.send_invitation(@user)
                flash[:notice] = "Invitation sent"
                redirect_to invites_path
            else 
                flash[:error] = "You already sent an invitation"
            end
        else
        redirect_to root_path   
        end
    end
    def index
        if is_client?
        @invitations = Invitation.where(user_id: current_user.id, confirmed: false)
        elsif
        @invitations = Invitation.where(worker_id: current_user.id, confirmed: false)
        end
    end
    def update
        @invitation = Invitation.find(params[:id])
        if is_worker? && current_user?(@invitation.worker_id)
            @invitation.update_attribute(:confirmed, true)
            flash[:notice] = "Invitation Accepted"
            redirect_to invites_path
        end
    end
end
