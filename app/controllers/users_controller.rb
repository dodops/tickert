class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to projects_path, notice: "You've signed up successfully."
    else
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation )
  end
end
