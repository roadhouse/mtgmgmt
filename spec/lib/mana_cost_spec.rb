require './lib/mana_cost'

describe ManaCost do
  context "from colorless costs" do
    context ".value" do
      subject { ManaCost.new("{3}").value }
      it { is_expected.to eql 3 }
    end
  end
end
