require 'spec_helper'

describe 'An anonymous user' do
  context 'who visits the signup path'do
    it 'can create an account by filling in the forms with valid credentials' do
      visit '/signup'
      fill_in "user_email", with: "danmee10@gmail.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_on "Submit"
      expect(current_path).to eq root_path
      expect(User.all.count).to eq 1
      expect(User.all.first.email).to eq "danmee10@gmail.com"
    end

    it 'can not create account without an email' do
      visit '/signup'
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_on "Submit"
      expect(current_path).to eq signup_path
      expect(User.all.count).to eq 0
      expect(page).to have_content "Invalid email or password."
    end

    it 'can not create account without a valid email' do
      visit '/signup'
      fill_in "user_email", with: "danmee10.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_on "Submit"
      expect(current_path).to eq signup_path
      expect(User.all.count).to eq 0
      expect(page).to have_content "Invalid email or password."
    end

    it 'can not create account without a unique email' do
      User.create(email: "danmee10@gmail.com", password: "password")
      visit '/signup'
      fill_in "user_email", with: "danmee10@gmail.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_on "Submit"
      expect(page).to have_content "Invalid email or password."
      expect(current_path).to eq signup_path
      expect(User.all.count).to eq 1
    end

    it 'can not create account without valid password' do
      visit '/signup'
      fill_in "user_email", with: "danmee10@gmail.com"
      fill_in "user_password", with: "pas"
      fill_in "user_password_confirmation", with: "pas"
      click_on "Submit"
      expect(page).to have_content "Invalid email or password."
      expect(current_path).to eq signup_path
      expect(User.all.count).to eq 0
    end

    it 'can not create account without matching password confirmation' do
      visit '/signup'
      fill_in "user_email", with: "danmee10@gmail.com"
      fill_in "user_password", with: "pas999999"
      fill_in "user_password_confirmation", with: "pas111111"
      click_on "Submit"
      expect(page).to have_content "Invalid email or password."
      expect(current_path).to eq signup_path
      expect(User.all.count).to eq 0
    end
  end
end
