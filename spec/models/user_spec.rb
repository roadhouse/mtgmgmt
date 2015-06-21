require 'spec_helper'

describe User do
  let(:collection) { create(:collection) }

  context ".percent_from2" do
    let(:card1) { create(:card, name: "Erase") }
    let(:card2) { create(:card, name: "Roast") }

    subject { collection.user.percent_from2([card1, card2]) }

    it { is_expected.to eq 100.0 }
  end
end
