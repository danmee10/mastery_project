class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      login(@user.email, @user.password)
      flash[:notice] = "Account created! Welcome #{@user.email}!"
      redirect_back_or_to root_path
    else
      flash[:error] = "Invalid email or password."
      redirect_to signup_path
    end
  end
end
