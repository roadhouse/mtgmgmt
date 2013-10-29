require 'app/models/deck_factory.rb'

describe DeckFactory do
  its(:deck) { should_not be_nil }
end
