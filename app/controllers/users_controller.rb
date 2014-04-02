class UsersController < ApplicationController
  include UsersHelper
  
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
    	redirect_to user_path(@user)
    else
      render 'new'
    end
  end

   def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.errors.empty?
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  

  private

  def user_params
  	params.require(:user).permit(:login, :email, :birthday, 
                                 :password, :password_confirmation)
  end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end
end
