require 'spec_helper'

describe ListsController do
  let(:inventory) { create(:inventory) }
  let(:user) { inventory.user }

  context "GET on /index" do
    before do
      get :show, user_id: user.id, name: inventory.list
    end

    context "response" do
      subject { response }

      it { is_expected.to be_success }
    end
  end
end
