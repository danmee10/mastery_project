require 'spec_helper'

describe PoemsController do

  let(:poem) { Poem.create(title: "test", original_text: "Words for editing.") }
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
      poem
      params = {id: 1}
      get :edit, params
      expect(assigns[:poem].original_text).to eq "Words for editing."
    end

    it 'adds the poem to the current users poems if they sign in after creating it' do
      poem
      user = User.create(email: "dan@mee.com", password: "password")
      params = {id: 1}
      get :edit, params
      expect(Poem.find(1).user_id).to eq nil
      login_user(user)
      get :edit, params
      expect(Poem.find(1).user_id).to eq 1
    end
  end

  describe 'PUT #update' do
    context 'given valid attributes' do
      it 'updates the attributes for the given poem and redirects to edit page' do
        poem
        params = {"poem"=>{"max_lines"=>"6", "max_syllables"=>"10"}, "id"=>"1"}
        put :update, params
        expect(assigns[:poem].max_lines).to eq 6
        expect(assigns[:poem].max_syllables).to eq 10
        expect(response).to redirect_to(edit_poem_path(1))
      end
    end

    context 'given invalid attributes' do
      it 'does not save any changes to the poems attributes' do
        poem
        params = {"poem"=>{"max_lines"=>"-6", "max_syllables"=>"10"}, "id"=>"1"}
        put :update, params
        poem = Poem.find(1)
        expect(poem.max_lines).to eq 4
        expect(poem.max_syllables).to eq 8
        expect(response).to redirect_to(edit_poem_path(1))
      end
    end
  end

  describe 'GET #index' do
    it 'renders the index view' do
      get :index
      expect(response).to render_template :index
    end

    it 'retrieves all the public poems for display' do
      Poem.create(original_text: "this is text")
      Poem.create(original_text: "this is more text")
      Poem.create(original_text: "this is more text", public_poem: false)
      get :index
      expect(assigns[:poems].count).to eq 2
    end

    it 'only retrieves poems matching the search criteria if any exist' do
      Poem.create(title: "test", original_text: "this is text")
      Poem.create(title: "heroku", original_text: "this is more text")
      Poem.create(title: "test", original_text: "this is more text")
      get :index, { search: "test" }
      expect(assigns[:poems].count).to eq 2
    end
  end

  describe 'GET #show' do
    it 'renders the index view' do
      poem
      get :show, { id: 1 }
      expect(response).to render_template :show
    end

    it 'retrieves the poem with the given id' do
      poem
      get :show, { id: 1}
      expect(assigns[:poem].id).to eq 1
      expect(assigns[:poem].title).to eq "test"
    end
  end
end
