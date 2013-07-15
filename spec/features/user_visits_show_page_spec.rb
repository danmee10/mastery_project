require 'spec_helper'

describe "A user's show page" do
  let(:user) { User.create(email: "danmee@gmail.com", password: "password") }

  def login(email, password)
    visit '/login'
    fill_in "email", with: email
    fill_in "password", with: password
    within(".auth-form") do
      click_on "Login"
    end
  end

  it "can only be accessed by the user who it represents" do
    login(user.email, "password")
    user2 = User.create(email: "email@email.com", password: "password")
    visit user_path(user)
    expect(page).to have_content "All poems Public poems Private poems"
    expect(current_path).to eq user_path(user)
    visit user_path(user2)
    expect(page).to have_content "You are not authorized to visit that page!"
    expect(current_path).to eq root_path
    click_on "Logout"
    visit user_path(user2)
    expect(page).to have_content "You must login to visit that page!"
    expect(current_path).to eq login_path
  end
end
