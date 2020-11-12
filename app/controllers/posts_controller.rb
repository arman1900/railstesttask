class PostsController < ApplicationController
    before_action :client
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        if @post.save
            redirect_to root_path
        else
            render :new
        end
    end
    def new 
        @post = Post.new
    end
    def destroy
        Post.find(params[:id]).destroy! 
        redirect_to post
    end
    private 
    def client
        unless  is_client?
            flash[:error] ="You're not a client"
            redirect_to root_path
        end
    end
    def post_params 
        params.require(:post).permit(:body)
    end
end
