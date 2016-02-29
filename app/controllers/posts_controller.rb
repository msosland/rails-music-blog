class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    if logged_in?
      render 'new'
    else
      redirect_to '/login'
    end
  end

  def create
    if logged_in?
      @post = Post.create(post_params)
      @post.user = current_user
      @post.save
      redirect_to @post
    else
      redirect_to '/login'
    end
  end

  def show
    set_post
  end

  def edit
    set_post
    if @post.user == current_user
      render 'edit'
    else
      redirect_to 'login'
    end
  end

  def update
    set_post
    if @post.user == current_user
      if @post.update_attributes(post_params)
        redirect_to @post
      end
    else
      redirect_to '/login'
    end
  end

  def destroy
    set_post
    if @post.user == current_user
      @post.destroy
      redirect_to posts_url
    else
      redirect_to '/login'
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end