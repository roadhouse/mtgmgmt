require './lib/mana_cost'

describe ManaCost do
  context "from colorless costs" do
    context ".value" do
      subject { ManaCost.new("{3}").value }
      it { is_expected.to eql 3 }
    end

    context ".colorless?" do
      subject { ManaCost.new("{3}").colorless? }

      it { is_expected.to be_truthy }
    end

  end
end
