require 'spec_helper'

describe "A user on the edit page" do
  let(:user) { User.create(email: "danmee@gmail.com", password: "password") }

  def login(email, password)
    visit '/login'
    fill_in "email", with: email
    fill_in "password", with: password
    within(".auth-form") do
      click_on "Login"
    end
  end

  context "who isn't signed in" do
    context "after entering original text into the main form and clicking begin" do
      before :each do
        visit "/"
        fill_in :poem_original_text, with: "Words for the editing"
        click_on "Begin!"
      end

      it "can view the original text", js: true do
        expect(current_path).to eq edit_poem_path(1)
        expect(page).to have_content "Words for the editing"
      end

      xit "can edit the poem text" do
        #NEED TO WRITE AND API::POEMCONTROLLER SPEC FOR THIS
        expect(Poem.all.first.original_text).to eq "Words for the editing"
        expect(Poem.all.first.poem_text).to eq "Words for the editing"
        click_on "Words"
        fill_in :original_word, with: "Statements"
        click_on "Replace"
        expect(Poem.all.first.poem_text).to eq "Statements for the editing"
      end

      it "can log in and be redirected back to the edit screen with the poem saved to their account", js: true do
        expect(current_path).to eq edit_poem_path(1)
        login(user.email, "password")
        expect(current_path).to eq edit_poem_path(1)
        expect(user.poems.count).to eq 1
        expect(user.poems.first.poem_text).to eq "Words for the editing"
      end

      it "can create an account and be redirected back to the edit screen with the poem saved to their account", js: true do
        expect(current_path).to eq edit_poem_path(1)
        click_on "Sign up"
        fill_in "user_email", with: "email@email.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        click_on "Submit"
        expect(User.all.count).to eq 1
        expect(current_path).to eq edit_poem_path(1)
        expect(User.all.last.poems.first.poem_text).to eq "Words for the editing"
      end
    end
  end

  context "who is logged into their account" do
    it "can edit the original text and save the poem for later", js: true do
      login(user.email, "password")
      visit "/"
      fill_in :poem_original_text, with: "Words for the editing"
      click_on "Begin!"
      expect(user.poems.count).to eq 1
      expect(user.poems.first.poem_text).to eq "Words for the editing"
    end

    it "can not edit any poems that do not belong to them", js: true do
      user1 = User.create(email: "emai@email.com", password: "password")
      poem = Poem.create(original_text: "These are the words of the poem", poem_text: "These are more words")
      poem.user_id = 1
      poem.save
      login(user.email, "password")
      visit "/"
      fill_in :poem_original_text, with: "Words for the editing"
      click_on "Begin!"
      expect(current_path).to eq edit_poem_path(2)
      expect(user.id).to eq 2
      visit edit_poem_path(1)
      expect(page).to have_content "You are not authorized to visit that page!"
      expect(current_path).to eq "/"
    end
  end
end
