require 'spec_helper'

describe PoemsController do
  describe 'POST #create' do
    it 'creates a new poem' do
      params = {poem: { original_text: "Words for editing." }}
      post :create, params
      expect(Poem.count).to eq 1
      expect(assigns[:poem].poem_text).to eq "Words for editing."
      expect(assigns[:poem].original_text).to eq "Words for editing."
    end
  end

  describe 'GET #edit' do
    it 'receives a poem with original_text' do
      poem = Poem.create(original_text: "Words for editing.")
      params = {id: 1}
      get :edit, params
      expect(assigns[:poem].original_text).to eq "Words for editing."
    end
  end

  describe 'PUT #update' do
    it 'updates the attributes for the given poem' do
      poem = Poem.create(original_text: "Words for editing.")
      params = {"poem"=>{"max_lines"=>"6", "max_syllables"=>"10"}, "commit"=>"Update", "id"=>"1"}
      put :update, params
      expect(assigns[:poem].max_lines).to eq 6
      expect(assigns[:poem].max_syllables).to eq 10
    end
  end
end
