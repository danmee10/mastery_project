class UsersController < ApplicationController
  before_filter :require_login, :only => [:edit, :update]
  before_filter :authenticate, :only => [:edit, :update]

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_back_or_to root_path, notice: "Account updated!"
    else
      flash[:error] = "Invalid email or password"
      redirect_to edit_user_path(@user)
    end
  end
end
