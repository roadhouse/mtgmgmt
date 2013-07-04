require 'spec_helper'

describe SearchesController do
  context "GET /index" do
    before { get :index }

    it { assigns(:search).should_not be_nil }
  end

  context "POST /create" do
    context "with params" do
      let!(:card) { create(:card) }  
      let(:search_param) { {search: {name:  "goblin"}} }

      before { post :create, search_param }

      it { assigns(:cards).should_not be_nil }
    end
  end
end
