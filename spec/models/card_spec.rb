require "spec_helper"
require "./app/models/card"

describe Card do
  context "#on_demand_price", :vcr do
    let(:card) { create(:card) }
    subject { create(:card).on_demand_price }

    it { is_expected.to be_eql 1.75 }
  end
end
