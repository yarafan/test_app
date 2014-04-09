class CommentsController < ApplicationController

  def create
  	@post = Post.find(params[:post_id])
    @comment = @post.comments.create!(com_params)
    respond_to do |format|
      format.js
      format.html { redirect_to @post }
    end
  end
  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.update_attributes(com_params)
    if @post.errors.empty?
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def destroy
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.find(params[:id])
  	@comment.destroy

  	respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js   
    end
  	
  end

  private

  def com_params
    params.require(:comment).permit(:body, :user_id)
  end
end
