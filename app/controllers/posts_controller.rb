class PostsController < ApplicationController
    before_action :client, only: [:create,:new]
    def index
        if params[:search]
            @posts = Post.search(params[:search]).order("created_at DESC")
        else
            @posts = Post.all.paginate(page: params[:page], per_page: 20)
        end
    end
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        if @post.save
            flash[:success] = "Post successfully added."
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
        redirect_to posts_path
    end
    def show 
        @post = Post.find(params[:id])
    end
    def feed
        @post = Post.where(user_id: current_user.id)
    end
    def edit
        @post = Post.find(params[:id])
        if !current_user?(@post.user.id)
            redirect_to root_path 
        end 
    end
    def update
        begin
            @post = Post.find(params[:id])
        rescue
            flash[:error] = "Post does not exixt"
        ensure 
            if @post.update_attributes(post_params)
                flash[:notice] = "You succesfully edited your post"
                redirect_to posts_path
            else
                render :new
            end
        end
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
