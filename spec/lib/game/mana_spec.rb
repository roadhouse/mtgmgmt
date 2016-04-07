require "rspec/its"
require "./lib/game/mana"
require "./lib/game/mana_cost"

describe Mana do
  let(:mana) { described_class.new "{2}{W}{W}" }

  subject { mana.manas }

  its(:size) { is_expected.to be_eql 3 }
  it { is_expected.to all be_a ManaCost }
end

