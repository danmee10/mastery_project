require 'spec_helper'

describe "A user" do
  context "who is not logged in" do
    it "can visit the poems index page and view all public poems" do
      Poem.create(original_text: "words words words", poem_text: "more words words", title: "test poem")
      visit poems_path
      expect(page).to have_link "test poem"
      expect(page).to have_content "Public Poems"
      expect(current_path).to eq poems_path
    end

    it "can click on a poem to view its show page, containing the poem_text, title and original_text" do
      poem = Poem.create(original_text: "words words words", poem_text: "more words words", title: "test poem")
      visit poems_path
      click_link "test poem"
      expect(current_path).to eq poem_path(poem)
      expect(page).to have_content "Test Poem"
      expect(page).to have_content "words words words"
      expect(page).to have_content "more words words"
    end

    it "can not view the show page for any private poem" do
      poem = Poem.create(original_text: "words words words", poem_text: "more words words", title: "test poem", :public_poem => false)
      visit poem_path(1)
      expect(page). to have_content "You must login to visit that page!"
      expect(current_path).to eq login_path
    end
  end

  context "who is logged in" do
    it "can only view the show page for private poems if they are the creater of them" do
      user = User.create(email: "email@email.com", password: "password")
      user2 = User.create(email: "email2@email.com", password: "password2")
      poem = Poem.create(original_text: "words words words", poem_text: "more words words", title: "test poem", :public_poem => false)
      poem.user_id = 2
      poem.save
      visit '/login'
      fill_in "email", with: user.email
      fill_in "password", with: "password"
      within(".auth-form") do
        click_on "Login"
      end
      visit poem_path(1)
      expect(page). to have_content "You are not authorized to visit that page!"
      expect(current_path).to eq root_path
    end
  end
end
