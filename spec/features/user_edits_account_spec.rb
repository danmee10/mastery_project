require 'spec_helper'

describe "User accounts" do
  let(:user) { User.create(email: "danmee@gmail.com", password: "password") }

  def login(email, password)
    visit '/login'
    fill_in "email", with: email
    fill_in "password", with: password
    within(".auth-form") do
      click_on "Login"
    end
  end

  context "a logged in user" do
    it "can change their own email or password" do
      login(user.email, "password")
      visit edit_user_path(user)
      expect(User.find(1).email).to eq "danmee@gmail.com"
      fill_in "email", with: "happy@face.clown"
      fill_in "password", with: "partywoo"
      fill_in "user_password_confirmation", with: "partywoo"
      click_on "Submit"
      expect(User.find(1).email).to eq "happy@face.clown"
      click_on "Logout"
      login("happy@face.clown", "partywoo")
      expect(page).to have_content "Welcome back, happy@face.clown"
    end

    it "can not access the account page of any other user" do
      User.create(email: "wer@wer.wer", password: "pokpokpok")
      login(user.email, "password")
      expect(User.find(2).email).to eq "danmee@gmail.com"
      visit '/users/1/edit'
      expect(page).to have_content "You are not authorized to visit that page!"
      expect(current_path).to eq root_path
    end
  end

  context "someone who isn't logged in" do
    it "can not access the account page of any user" do
      User.create(email: "wer@wer.wer", password: "pokpokpok")
      visit '/users/1/edit'
      expect(page).to have_content "You must login to visit that page!"
      expect(current_path).to eq login_path
    end
  end
end
