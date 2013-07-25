require 'spec_helper'

describe UsersController do
  describe "POST #create" do
    it 'creates a user' do
      params = { user: { email: "dan@dan.dan", password: "password"}}
      post :create, params
      expect(assigns(:user).class).to eq User
      expect(User.all.count).to eq 1
    end

    it 'welcomes new users' do
      params = { user: { email: "dan@dan.dan", password: "password"}}
      post :create, params
      expect(flash[:notice]).to eq "Account created! Welcome dan@dan.dan!"
    end
  end

  describe "PUT #update" do
    it "updates a users' information" do
      @user = User.create(email: "dan@dan.dan", password: "password")
      controller.stub(:require_login).and_return(nil)
      controller.stub(:authenticate).and_return(nil)
      params = { email: "dan@dan.mee", password: "password", password_confirmation: "password"}
      put :update, :id => @user.id, :user => params
      expect(assigns[:user].class).to eq User
      expect(assigns[:user].email).to eq "dan@dan.mee"
    end
  end

  describe "GET #show" do
    it "finds the correct user" do
      @user = User.create(email: "email@email.com", password: "password")
      controller.stub(:require_login).and_return(nil)
      controller.stub(:authenticate).and_return(nil)
      get :show, :id => @user.id
      expect(assigns[:user].class).to eq User
      expect(assigns[:user].email).to eq "email@email.com"
    end
  end

  describe "GET #edit" do
    it 'finds the correct user' do
      @user = User.create(email: "email@email.com", password: "password")
      controller.stub(:require_login).and_return(nil)
      controller.stub(:authenticate).and_return(nil)
      get :edit, :id => @user.id
      expect(assigns[:user].class).to eq User
      expect(assigns[:user].email).to eq "email@email.com"
    end
  end
end
