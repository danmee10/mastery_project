class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:sessions][:email], params[:sessions][:password], params[:sessions][:remember_me])

    if user
      redirect_back_or_to root_path, notice: "Welcome back, #{current_user.email}!"
    else
      flash[:error] = "Email or password was invalid."
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Logged out!"
  end
end
