class SessionsController < ApplicationController

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out successfully."
    redirect_to root_url
  end

  def new
  end

  def create
    user = User.where(:name => params[:signin][:name]).first

    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Signed in successfully."
    else
      flash[:notice] = "Sorry."
      render :new
    end
  end
end
