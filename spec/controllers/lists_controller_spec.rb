require 'spec_helper'

describe ListsController do
  let(:inventory) { create :inventory }
  let(:user) { inventory.user }

  context "GET on /index" do
    before { get :show, params: { user_id: user.id, name: inventory.list } }

    context "response" do
      subject { response }

      it { is_expected.to be_success }
    end

    context "inventry collection" do
      subject { assigns :inventories }

      it { is_expected.to_not be_nil }
    end
  end
end
