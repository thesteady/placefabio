require 'spec_helper'

describe WordsController do

  let(:valid_attributes) {
    {name: 'abyss', category: 'fantasy'}
  }

  let(:invalid_attributes) {
    {name: 'abyss', category: 'asdfefasdf'}
  }

  describe "GET #show" do
    it "assigns the requested word as @word" do
      word = Word.create! valid_attributes
      get :show, {id: word.to_param, format: :json}
      expect(assigns(:word)).to eq(word)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Word" do
        expect {
          post :create, {word: valid_attributes, format: :json}
        }.to change(Word, :count).by(1)
      end

      it "assigns a newly created word as @word" do
        post :create, {word: valid_attributes, format: :json}
        expect(assigns(:word)).to be_a(Word)
        expect(assigns(:word)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved word as @word" do
        post :create, {word: invalid_attributes, format: :json}
        expect(assigns(:word)).to be_a_new(Word)
      end

      it "returns a 422 status" do
        post :create, {word: invalid_attributes, format: :json}
        expect(response.status).to eq(422)
      end
    end
  end
end
