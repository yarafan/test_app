class PostsController < ApplicationController
  
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
    @search = Post.search do
    fulltext params[:search]
    end
    @posts = @search.results
    end
  end

  def new
    @post = Post.new
  end

  def edit
  	@post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
    	redirect_to post_path(@post)
    else
      render 'new'
    end
  end

   def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)
    if @post.errors.empty?
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
  	 params.require(:post).permit(:title, :text, :image, :tag_list)
  end
end
