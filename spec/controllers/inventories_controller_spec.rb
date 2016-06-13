require 'spec_helper'

describe InventoriesController, type: :controller do
  let(:inventory) { create(:inventory) }
  let(:card) { inventory.card }
  before { sign_in inventory.user }

  context "POST on /create" do
    before do
      post :create, inventory: { card_id: card.id, copies: 4, list: inventory.list }
    end

    context "response" do
      subject { response }

      it { is_expected.to be_success }
    end

    context "inventory instance" do
      subject { assigns(:inventory) }

      it { is_expected.not_to be_nil }
      it { is_expected.to be_a Inventory }

      its(:"class.count") { is_expected.to eq 1 }
      its(:user_id) { is_expected.to eq inventory.user.id }
      its(:card_id) { is_expected.to eq card.id }
      its(:copies) { is_expected.to eq 5 }
      its(:list) { is_expected.to eq inventory.list }
    end
  end

  context "GET on /want" do
    context "response" do
      before { get :want }
      subject { response }

      it { is_expected.to be_success }
    end

    context "respond in json" do
      before { get :want, format: :json }
      subject { response }

      it { is_expected.to be_success }
      its(:content_type) { is_expected.to eq "application/json" }
    end
  end
end
