class CommentsController < ApplicationController
    before_action :worker, only: [:create,:new]
    def new
        @comment = Comment.new(post_id: params[:post_id])
    end
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            flash[:success] = "Comment successfully added"
            redirect_to post_path(@comment.post)
        else
            render 'new'
        end
    end
    def destroy
        @comment = Comment.find(params[:id])
        if !current_user?(@comment.user.id)
            redirect_to root_path 
        end 
        @comment.destroy! 
        redirect_to posts_path
    end
    private
    def worker
        unless  is_worker?
            flash[:error] ="You're not a worker"
            redirect_to root_path
        end
    end
    def comment_params
        params.require(:comment).permit(:body,:post_id)
    end
end
