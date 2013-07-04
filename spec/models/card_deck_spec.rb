require "spec_helper_active_record.rb"
require "./app/models/card_deck.rb"

describe CardDeck do
  it { should allow_mass_assignment_of :copies }
  it { should allow_mass_assignment_of :card }
  it { should allow_mass_assignment_of :deck }
  
  it { should belong_to :card }
  it { should belong_to :deck }
end 
