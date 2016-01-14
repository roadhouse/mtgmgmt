require 'spec_helper'

describe ListsController do
  let(:inventory) { create(:inventory) }
  let(:logged_user) { inventory.user }
  let(:card) { inventory.card }

  before { allow(controller).to receive(:current_user) { logged_user } }

  context "POST on /create" do
    before do
      post :index, user_id: logged_user.id
    end

    context "response" do
      subject { response }

      it { is_expected.to be_success }
    end
  end
end
