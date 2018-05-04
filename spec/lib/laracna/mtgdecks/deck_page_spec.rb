describe Laracna::Mtgdecks::DeckPage, :vcr do
  let(:main) do
    {
      "Rakdos Cackler" => "4",
      "Stormbreath Dragon" => "2",
      "Burning-Tree Emissary" => "4",
      "Firefist Striker" => "4",
      "Ash Zealot" => "4",
      "Fanatic of Mogis" => "2",
      "Boros Reckoner" => "4",
      "Chandra's Phoenix" => "4",
      "Magma Jet" => "4",
      "Boros Charm" => "2",
      "Lightning Strike" => "2",
      "Chained to the Rocks" => "3",
      "Mountain" => "8",
      "Mutavault" => "3",
      "Temple of Triumph" => "4",
      "Sacred Foundry" => "4",
      "Nykthos, Shrine to Nyx" => "2"
    }
  end

  let(:sideboard) do
    {
      "Assemble the Legion" => "2",
      "Chained to the Rocks" => "1",
      "Boros Charm" => "2",
      "Ratchet Bomb" => "2",
      "Skullcrack" => "2",
      "Spark Trooper" => "2",
      "Warleader's Helix" => "2",
      "Burning Earth" => "2"
    }
  end

  let(:url) { "http://www.mtgdecks.net/decks/view/63963" }

  subject { described_class.new url }

  its(:description) { is_expected.to eql "R/W Devotion.Builder: Lerchenmüller, Max.Top4Heldenschmiede Kempten[13 Players] 11-Jan-2014" }
  its(:name) { is_expected.to eql "R/W Devotion" }
  its(:main) { is_expected.to eql main }
  its(:sideboard) { is_expected.to eql sideboard }
end
