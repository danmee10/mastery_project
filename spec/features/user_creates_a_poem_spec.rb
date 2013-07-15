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

      it "can view the original text" do
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

      it "can log in and save the poem to their account" do
        expect(current_path).to eq edit_poem_path(1)
        login(user.email, "password")
        expect(current_path).to eq edit_poem_path(1)
        expect(user.poems.count).to eq 1
        expect(user.poems.first.poem_text).to eq "Words for the editing"
      end
    end
  end

  context "who is logged into their account" do
    it "can edit the original text and save the poem for later" do
      login(user.email, "password")
      visit "/"
      fill_in :poem_original_text, with: "Words for the editing"
      click_on "Begin!"
      expect(user.poems.count).to eq 1
      expect(user.poems.first.poem_text).to eq "Words for the editing"
    end
  end
end
