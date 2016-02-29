class UsersController < ApplicationController

  def index
    redirect_to posts_url
  end

  def new
    @user = User.new
  end

  def show
    set_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect '/'
    else
      render 'new'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
end