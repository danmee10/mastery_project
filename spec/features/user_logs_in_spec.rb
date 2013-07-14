require 'spec_helper'

describe 'A user who has previously made an account' do

  let!(:user) { User.create(email: "danmee10@example.com", password: "password")}

  context 'that visits the login page' do
    it 'can log into their account by filling in their credentials' do
      visit '/login'
      fill_in "email", with: "danmee10@example.com"
      fill_in "password", with: "password"
      within(".auth-form") do
        click_on "Login"
      end
      expect(current_path).to eq root_path
      expect(page).to have_content "Welcome back, danmee10@example.com!"
    end

    it 'will see an error message if an invalid email is entered' do
      visit '/login'
      fill_in "email", with: "danmee10@ee.com"
      fill_in "password", with: "password"
      within(".auth-form") do
        click_on "Login"
      end
      expect(current_path).to eq login_path
      expect(page).to have_content "Email or password was invalid."
    end

    it 'will see an error message if an invalid password is entered' do
      visit '/login'
      fill_in "email", with: "danmee10@example.com"
      fill_in "password", with: "paord"
      within(".auth-form") do
        click_on "Login"
      end
      expect(current_path).to eq login_path
      expect(page).to have_content "Email or password was invalid."
    end
  end
end
