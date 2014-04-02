class SessionsController < ApplicationController

  def new
  end

  def create 
   user = User.authenticate(params[:login], params[:password])
     if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => " #{current_user.login} logged in"
    else
      flash.now[:error] = "Invalid"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
 end
