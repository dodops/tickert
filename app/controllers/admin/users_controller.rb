class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    params = user_params.dup
    params[:password_confirmation] = params[:password]
    @user = User.new(params)

    if @user.save
      redirect_to admin_users_path, notice: "User has been created."
    else
      flash.now[:notice] = "User has not been created."
    end
  end

  def show
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User has been updated."
    else
      flash[:notice] = "User has not been updated."
      render action: "edit"
    end
  end

  def edit
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
