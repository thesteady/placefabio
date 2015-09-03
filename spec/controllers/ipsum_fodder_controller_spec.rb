require 'spec_helper'

describe IpsumFodderController do
  describe 'GET #index' do
    before do
      get :index
    end

    it 'is a success' do
      expect(response).to be_success
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end
  end
end
