class SessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]

  def new
  end

  def create
    user = login(params[:sessions][:email], params[:sessions][:password], params[:sessions][:remember_me])

    if user
      if session[:current_poem]
        redirect_to edit_poem_path(session[:current_poem]), notice: "Welcome back, #{current_user.email}!"
      else
        redirect_back_or_to root_path, notice: "Welcome back, #{current_user.email}!"
      end
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
