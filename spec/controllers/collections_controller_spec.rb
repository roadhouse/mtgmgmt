require 'spec_helper'

describe CollectionsController, type: :controller do
  let(:collection) { create(:collection) }
  let(:logged_user) { collection.user }

  before { allow(controller).to receive(:current_user) { logged_user } } 

  context "PUT on /update" do
    let!(:card) { create(:card) }

    before do
      request.env["HTTP_REFERER"] = 'http://test.hostprevious_page'

      put :update, id: collection.id, collection: { card_id: card.id, copies: 4, list: collection.name }
    end

    context "response" do
      subject { response }

      it { is_expected.to redirect_to(:back) }
    end

    context "collection instance" do
      subject { assigns(:collection) }

      it { is_expected.not_to be_nil }
      it { is_expected.to be_a Collection }

      its(:"class.count") { is_expected.to eq 1 }
      its(:user_id) { is_expected.to eq logged_user.id }
      its(:name) { is_expected.to eq collection.name }

      context "card list" do
        let(:another_card) { create(:card, name: "Naturalize") }
        subject { assigns(:collection).list }

        its(["Magma Jet", "total"]) { is_expected.to eq 4 }
        its(["Magma Jet", "Theros", "normal"]) { is_expected.to eq 4 }

        it "update current list" do
          request.env["HTTP_REFERER"] = 'http://test.hostprevious_page'

          put :update, id: collection.id, collection: { card_id: another_card.id, copies: 1, list: collection.name }

          expect(subject["Naturalize"]["total"]).to eq 1
          expect(subject["Naturalize"]["Theros"]["normal"]).to eq 1

          expect(subject.keys).to eq ["Erase", "Roast", "Magma Jet", "Naturalize"]
        end
      end
    end
  end

  context "POST on /create" do
    let!(:card) { create(:card) }

    before do
      request.env["HTTP_REFERER"] = 'http://test.hostprevious_page'
      post :create, collection: { card_id: card.id, user_id: 1, copies: 4, list: "list" }
    end

    context "response" do
      subject { response }

      it { is_expected.to redirect_to(:back) }
    end

    context "collection instance" do
      subject { assigns(:collection) }

      it { is_expected.not_to be_nil }
      it { is_expected.to be_a Collection }

      its(:"class.count") { is_expected.to eq 1 }
      its(:user_id) { is_expected.to eq logged_user.id }
      its(:name) { is_expected.to eq "list" }

      context "card list" do
        let(:another_card) { create(:card, name: "Erase") }
        subject { assigns(:collection).list }

        its(["Magma Jet", "total"]) { is_expected.to eq 4 }
        its(["Magma Jet", "Theros", "normal"]) { is_expected.to eq 4 }

        it "update current list" do
          request.env["HTTP_REFERER"] = 'http://test.hostprevious_page'
          post :create, collection: { card_id: another_card.id, user_id: 1, copies: 4, list: "list" }

          expect(subject["Erase"]["total"]).to eq 4
          expect(subject["Erase"]["Theros"]["normal"]).to eq 4
        end
      end
    end
  end
end
