require 'spec_helper'

describe "A user on the home page" do
  it "will see content" do
    visit '/'
    expect(page).to have_content "PoemEngine"
    expect(page).to have_content "Enter Text!"
    expect(page).to have_field "text"
  end

  context "that isn't logged in" do
    xit "can enter text" do
      visit '/'
      fill_in :text, with: "The trash can is with garbage"
      click_on :submit
      expect
    end

    it "can login"
    it "can signup"
  end
end
