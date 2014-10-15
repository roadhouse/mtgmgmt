require 'ostruct'
require './lib/app/turn.rb'

describe Turn do
  context "500.1. A turn consists of five phases, in this order: beginning, precombat main, combat, postcombat main, and ending." do
    subject { Turn.new }
    its(:phases) { should be_eql [:beginning, :precombat_main, :combat, :postcombat_main, :ending] }
  end
end
