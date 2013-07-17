require 'spec_helper'

describe "A user" do
  let(:user) { User.create(email: "danmee@gmail.com", password: "password") }
  let(:poem) { Poem.create(original_text: "bla bla bla", poem_text: "this is more BLA") }

  def login(email, password)
    visit '/login'
    fill_in "email", with: email
    fill_in "password", with: password
    within(".auth-form") do
      click_on "Login"
    end
  end

  context "who is logged in" do
    it "can change the visibility of a poem" do
      login(user.email, "password")
      poem.user_id = 1
      poem.save
      visit edit_poem_path(poem)
      expect(user.poems.first.public_poem).to eq true
      select('No', :from => 'poem_public_poem')
      click_on "Update"
      expect(user.poems.first.public_poem).to eq false
      select('Yes', :from => 'poem_public_poem')
      click_on "Update"
      expect(user.poems.first.public_poem).to eq true
    end
  end
end
