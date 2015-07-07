require 'spec_helper'

describe InventoriesController, type: :controller do
  context "PUT on /update" do
    before do
      request.env["HTTP_REFERER"] = 'http://test.hostprevious_page'
      patch :create, id: 3, inventory: { card_id: 2, user_id: 1, copies: 4 }
    end
    
    subject { response }

    it { is_expected.to redirect_to(:back) }
  end

  context "POST on /create" do
    before do
      request.env["HTTP_REFERER"] = 'http://test.hostprevious_page'
      post :create, inventory: { card_id: 2, user_id: 1, copies: 4, list: "list" }
    end

    context "response" do
      subject { response }

      it { is_expected.to redirect_to(:back) }
    end

    context "inventory instance" do
      subject { assigns(:inventory) }

      it { is_expected.not_to be_nil }
      it { is_expected.to be_a Inventory }

      its(:"class.count") { is_expected.to eq 1 }
      its(:user_id) { is_expected.to eq 1 }
      its(:card_id) { is_expected.to eq 2 }
      its(:copies) { is_expected.to eq 4 }
      its(:list) { is_expected.to eq "list" }
    end
  end
end
