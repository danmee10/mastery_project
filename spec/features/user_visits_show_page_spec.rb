require 'spec_helper'

describe "A user's show page" do
  let(:user) { User.create(email: "danmee@gmail.com", password: "password") }
  let(:poem) { Poem.create(original_text: "bla bla bla", poem_text: "this is more BLA") }
  let(:poem2) { Poem.create(original_text: "bla bla bla more of this", poem_text: "this is more BLA and more and and", title: "test poem") }

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

  context "for a user who has previously created poems" do
    it "will show a list of their poems" do
      user.poems << poem
      login(user.email, "password")
      visit user_path(user)
      expect(page).to have_content "Untitled"
    end

    it "can filter which poems are displayed by whether or not they are public", js: true do
      user.poems << poem
      user.poems << poem2
      poem2.public_poem = false
      poem2.save
      login(user.email, "password")
      visit user_path(user)
      click_on "All poems"
      expect(page).to have_content "Untitled"
      expect(page).to have_content "test poem"
      click_on "Private poems"
      expect(page).to_not have_content "Untitled"
      click_on "Public poems"
      expect(page).to_not have_content "test poem"
    end
  end

  # SQLite3::BusyException: database is locked:
  # INSERT INTO "users" ("created_at", "crypted_password", "email", "remember_me_token", "remember_me_token_expires_at", "reset_password_email_sent_at", "reset_password_token", "reset_password_token_expires_at", "salt", "updated_at") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)

  context "for a user with no poems" do
    it "will display a message saying that the user has no poems, and link to new_poem_path" do
      login(user.email, "password")
      visit user_path(user)
      expect(page).to have_content "You have no written any poems yet"
      expect(page).to have_link "Create Poem"
    end
  end
end
