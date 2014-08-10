class UsersController < ApplicationController
  before_action :find_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to projects_path, notice: "You've signed up successfully."
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile has been updated."
    else
      render :edit
    end
  end


  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation )
  end
end
