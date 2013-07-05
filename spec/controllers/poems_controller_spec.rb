require 'spec_helper'

describe PoemsController do
  describe 'POST #create' do
    it 'creates a new poem' do
      params = {poem: { original_text: "example123" }}
      post :create, params
      expect(Poem.count).to eq 1
    end
  end
end
