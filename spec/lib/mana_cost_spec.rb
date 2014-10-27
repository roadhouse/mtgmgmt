require 'spec_helper'

describe ManaCost do
  context "from colorless costs" do
    subject { ManaCost.new("{3}") }

    its(:value) { expect(subject.value).to eql 3 }
    its(:colorless?) { is_expected.to be_truthy }
    its(:colored?) { is_expected.not_to be_truthy }
  end

  context "colored costs" do
    context "1 red mana - {R}" do
      subject(:colored_manacost) { ManaCost.new("{R}") }

      its(:value) { is_expected.to eql 1 }
      its(:colored?) { is_expected.to be_truthy }
      its(:red?) { is_expected.to be_truthy }
      its(:black?) { is_expected.not_to be_truthy }
      its(:blue?) { is_expected.not_to be_truthy }
      its(:green?) { is_expected.not_to be_truthy }
      its(:white?) { is_expected.not_to be_truthy }
    end
    
    context "1 black mana - {B}" do
      subject(:colored_manacost) { ManaCost.new("{B}") }

      its(:value) { is_expected.to eql 1 }
      its(:colored?) { is_expected.to be_truthy }
      its(:black?) { is_expected.to be_truthy }
      its(:red?) { is_expected.not_to be_truthy }
      its(:blue?) { is_expected.not_to be_truthy }
      its(:green?) { is_expected.not_to be_truthy }
      its(:white?) { is_expected.not_to be_truthy }
    end

    context "1 blue mana - {U}" do
      subject(:colored_manacost) { ManaCost.new("{U}") }

      its(:value) { is_expected.to eql 1 }
      its(:colored?) { is_expected.to be_truthy }
      its(:blue?) { is_expected.to be_truthy }
      its(:black?) { is_expected.not_to be_truthy }
      its(:red?) { is_expected.not_to be_truthy }
      its(:green?) { is_expected.not_to be_truthy }
      its(:white?) { is_expected.not_to be_truthy }
    end

    context "1 green mana - {G}" do
      subject(:colored_manacost) { ManaCost.new("{G}") }

      its(:value) { is_expected.to eql 1 }
      its(:colored?) { is_expected.to be_truthy }
      its(:green?) { is_expected.to be_truthy }
      its(:black?) { is_expected.not_to be_truthy }
      its(:blue?) { is_expected.not_to be_truthy }
      its(:red?) { is_expected.not_to be_truthy }
      its(:white?) { is_expected.not_to be_truthy }
    end

    context "1 white mana - {W}" do
      subject(:colored_manacost) { ManaCost.new("{W}") }

      its(:value) { is_expected.to eql 1 }
      its(:colored?) { is_expected.to be_truthy }
      its(:white?) { is_expected.to be_truthy }
      its(:black?) { is_expected.not_to be_truthy }
      its(:blue?) { is_expected.not_to be_truthy }
      its(:green?) { is_expected.not_to be_truthy }
      its(:red?) { is_expected.not_to be_truthy }
    end
  end

  context "compond costs" do
    subject { Mana.new("{2}{R}") }

    its(:converted_manacost) { is_expected.to eql 3 }
    its(:manas) { is_expected.to eql Hash }
    

  end
end
