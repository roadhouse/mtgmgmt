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
    context "RED" do
      subject(:colored_manacost) { ManaCost.new("{R}") }

      context ".value" do
        subject { colored_manacost.value }

        it { is_expected.to eql 1 }
      end

      context ".colored?" do
        subject { colored_manacost.colored? }

        it { is_expected.to be_truthy }
      end

      context ".red?" do
        subject { colored_manacost.red? }

        it { is_expected.to be_truthy }
      end

      context "all others must be false" do
        methods = %i(black? blue? white? green?)
        methods.each do |method| 
          context method.to_s do
            subject { colored_manacost.send(method) }

            it { is_expected.to be_falsey }
          end
        end
      end
    end
    
    context "BLACK" do
      subject(:colored_manacost) { ManaCost.new("{B}") }

      context ".value" do
        subject { colored_manacost.value }

        it { is_expected.to eql 1 }
      end

      context ".colored?" do
        subject { colored_manacost.colored? }

        it { is_expected.to be_truthy }
      end

      context ".red?" do
        subject { colored_manacost.red? }

        it { is_expected.to be_falsey }
      end

      context "all others must be false" do
        methods = %i(red? blue? white? green?)
        methods.each do |method| 
          context method.to_s do
            subject { colored_manacost.send(method) }

            it { is_expected.to be_falsey }
          end
        end
      end
    end
  end
end
