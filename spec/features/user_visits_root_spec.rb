require 'spec_helper'

describe "A user on the home page" do
  it "will see content" do
    visit '/'
    expect(page).to have_content "PoemEngine"
    expect(page).to have_content "Enter Text!"
    expect(page).to have_field "poem_original_text"
  end

  context "that isn't logged in" do
    it "can enter text" do
      visit '/'
      fill_in :poem_original_text, with: "There are no words in here."
      expect(page).to have_button "Begin!"
      click_on "Begin!"
      expect(Poem.all.count).to eq 1
    end

    it "can login"
    it "can signup"
  end
end
