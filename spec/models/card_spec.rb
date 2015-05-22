require "spec_helper"
require "./app/models/card"

describe Card do
  context "#on_demand_price", :vcr do
    subject { card.on_demand_price }

    context "without price" do
      let(:card) { create(:card) }

      before { Delayed::Job.should_receive(:enqueue) }

      it { subject }
    end

    context "with price" do
      context "with outdated price" do
        let(:card) { create(:card, price: 6.66, price_updated_at: 1.day.ago) }

        before { expect(Delayed::Job).to receive(:enqueue) }

        it { subject }
      end
      context "with updated price" do
        let(:card) { create(:card, price: 6.66, price_updated_at: Time.zone.now) }

        before { Delayed::Job.should_not_receive(:enqueue) }

        it { subject }
      end
    end
  end
end
