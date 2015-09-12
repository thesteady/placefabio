require 'spec_helper'

describe IpsumFodderController do
  describe 'GET #new' do
    before do
      get :new
    end

    it 'is a success' do
      expect(response).to be_success
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      let(:input_text){ 'hello world' }
      let(:post!){ post :create, input_text: input_text }
      let(:expected_base_words){ ['hello', 'world'] }

      it "assigns base words to an array" do
        post!
        expect(assigns(:base_words)).to match(expected_base_words)
      end

      it "assigns words to the session" do
        post!
        expect(session["words"]).to eq(expected_base_words)
      end

      it "redirects to assign" do
        post!
        expect(response).to redirect_to(ipsum_fodder_assign_path)
      end
    end

    context "with invalid attributes" do
      let(:input_text){ '' }
      let(:post!){ post :create, input_text: input_text }

      it 'handles empty content' do
        post!
      end
    end
  end

  describe 'GET #assign' do
    context 'with words' do
      let(:words){ ['hello', 'world'] }

      before do
        session["words"] = words
        get :assign
      end

      it 'is a success' do
        expect(response).to be_success
      end

      it 'renders the assign template' do
        expect(response).to render_template :assign
      end

      it 'assigns base words' do
        expect(assigns(:base_words)).to eq(words)
      end

      it 'resets session words' do
        expect(session["words"]).to eq([])
      end

      it 'assigns categories' do
        expect(assigns(:categories).class).to eq(Array)
        expect(assigns(:categories).count > 1).to eq(true)
      end
    end

    context 'without words' do
      before do
        get :assign
      end

      it 'is a success' do
        expect(response).to be_success
      end

      it 'renders the assign template' do
        expect(response).to render_template :assign
      end
    end
  end
end
