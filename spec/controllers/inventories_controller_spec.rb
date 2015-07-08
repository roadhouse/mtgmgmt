require 'spec_helper'

describe InventoriesController, type: :controller do
  context "PUT on /update" do
    let!(:card) { create(:card) }
    let(:inventory) { create(:inventory, user_id: 1, card_id: card.id, list: "list") }

    before do
      request.env["HTTP_REFERER"] = 'http://test.hostprevious_page'
      put :update, id: inventory.id, inventory: { card_id: card.id, user_id: 1, copies: 4 }
    end
    
    context "response" do
      subject { response }

      it { is_expected.to redirect_to(:back) }
    end

    context "inventory instance" do
      subject { Inventory.last }

      its(:user_id) { is_expected.to eq 1 }
      its(:card_id) { is_expected.to eq card.id }
      its(:copies) { is_expected.to eq 4 }
      its(:list) { is_expected.to eq "list" }
    end

    # context "collection instance" do
      # subject { assigns(:collection) }

      # it { is_expected.not_to be_nil }
      # it { is_expected.to be_a Collection }

      # its(:"class.count") { is_expected.to eq 1 }
      # its(:user_id) { is_expected.to eq 1 }
      # its(:name) { is_expected.to eq "list" }

      # context "card list" do
        # let(:another_card) { create(:card, name: "Erase") }
        # subject { assigns(:collection).list }

        # its(["Magma Jet", "total"]) { is_expected.to eq 4 }
        # its(["Magma Jet", "Theros", "normal"]) { is_expected.to eq 4 }

        # it "update current list" do
          # request.env["HTTP_REFERER"] = 'http://test.hostprevious_page'
          # post :create, inventory: { card_id: another_card.id, user_id: 1, copies: 4, list: "list" }

          # expect(subject["Erase"]["total"]).to eq 4
          # expect(subject["Erase"]["Theros"]["normal"]).to eq 4
        # end
      # end
    # end
  end

  context "POST on /create" do
    let!(:card) { create(:card) }

    before do
      request.env["HTTP_REFERER"] = 'http://test.hostprevious_page'
      post :create, inventory: { card_id: card.id, user_id: 1, copies: 4, list: "list" }
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
      its(:card_id) { is_expected.to eq card.id }
      its(:copies) { is_expected.to eq 4 }
      its(:list) { is_expected.to eq "list" }
    end

    context "collection instance" do
      subject { assigns(:collection) }

      it { is_expected.not_to be_nil }
      it { is_expected.to be_a Collection }

      its(:"class.count") { is_expected.to eq 1 }
      its(:user_id) { is_expected.to eq 1 }
      its(:name) { is_expected.to eq "list" }

      context "card list" do
        let(:another_card) { create(:card, name: "Erase") }
        subject { assigns(:collection).list }

        its(["Magma Jet", "total"]) { is_expected.to eq 4 }
        its(["Magma Jet", "Theros", "normal"]) { is_expected.to eq 4 }

        it "update current list" do
          request.env["HTTP_REFERER"] = 'http://test.hostprevious_page'
          post :create, inventory: { card_id: another_card.id, user_id: 1, copies: 4, list: "list" }

          expect(subject["Erase"]["total"]).to eq 4
          expect(subject["Erase"]["Theros"]["normal"]).to eq 4
        end
      end
    end
  end
end
