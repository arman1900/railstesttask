class CommentsController < ApplicationController
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
    private
    def comment_params
        params.require(:comment).permit(:body,:post_id)
    end
end
