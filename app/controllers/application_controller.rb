class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_signin!
    if current_user.nil? 
      redirect_to signin_url, notice: "You need to sign in or sign up before continuing."
    end
  end

  helper_method :require_signin!

  def authorize_admin!
    require_signin!
    redirect_to root_path, notice: "You must be an admin to do that." unless current_user.admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
