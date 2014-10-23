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

    context ".colored?" do
      subject { ManaCost.new("{3}").colored? }

      it { is_expected.to be_falsey }
    end
  end

  context "colored costs" do
    subject(:colored_manacost) { ManaCost.new("{R}") }

    context ".value" do
      subject { colored_manacost.value }

      it { is_expected.to eql 1 }
    end
  end
end
