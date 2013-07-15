class UsersController < ApplicationController
  before_filter :require_login, :only => [:edit, :update, :show]
  before_filter :authenticate, :only => [:edit, :update, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      auto_login(@user)
      if session[:current_poem]
        flash[:notice] = "Welcome back, #{current_user.email}!"
        redirect_to edit_poem_path(session[:current_poem])
      else
        flash[:notice] = "Account created! Welcome #{@user.email}!"
        redirect_to root_path
      end
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

  def show
    @user = User.find(params[:id])
  end
end
