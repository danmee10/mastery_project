class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login
    not_authenticated unless current_user
  end

  def authenticate
    if current_user && current_user.id != params[:id].to_i
      not_authorized
    end
  end

  def not_authenticated
    flash[:error] = "You must login to visit that page!"
    redirect_to "/login"
  end

  def not_authorized
    flash[:error] = "You are not authorized to visit that page!"
    redirect_to root_path
  end
end
