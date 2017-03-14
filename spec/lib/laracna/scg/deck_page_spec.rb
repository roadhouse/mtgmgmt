describe Laracna::Scg::DeckPage, :vcr do
  context "with a valid deck page" do
    let(:url) { "http://sales.starcitygames.com//deckdatabase/displaydeck.php?DeckID=91127" }

    let(:attributes_list) do
      %i(list description name url source)
    end

    let(:description) { is_expected.to eql "1st Place at StarCityGames.com Invitational Qualifier on 9/5/2015" }
    let(:name) { is_expected.to be_eql "Abzan Control" }

    let(:main) do
      {
        "Den Protector" => "4",
        "Siege Rhino" => "4",
        "Courser of Kruphix" => "4",
        "Dragonlord Dromoka" => "1",
        "Tasigur, the Golden Fang" => "1",
        "Elspeth, Sun's Champion" => "2",
        "Ugin, the Spirit Dragon" => "1",
        "Forest" => "2",
        "Plains" => "2",
        "Caves of Koilos" => "2",
        "Llanowar Wastes" => "4",
        "Sandsteppe Citadel" => "4",
        "Temple of Malady" => "4",
        "Temple of Silence" => "3",
        "Windswept Heath" => "4",
        "Urborg, Tomb of Yawgmoth" => "1",
        "Abzan Charm" => "4",
        "Bile Blight" => "1",
        "Dromoka's Command" => "2",
        "Hero's Downfall" => "3",
        "Murderous Cut" => "1",
        "Silence the Believers" => "1",
        "Ultimate Price" => "1",
        "Languish" => "1",
        "Thoughtseize" => "4"
      }
    end

    let(:sideboard) do
      {
        "Fleecemane Lion" => "3",
        "Gaea's Revenge" => "1",
        "Evolutionary Leap" => "1",
        "Ultimate Price" => "1",
        "Unravel the Æther" => "1",
        "Utter End" => "1",
        "Dragonlord Dromoka" => "1",
        "Whip of Erebos" => "1",
        "Duress" => "2",
        "Languish" => "1",
        "Tragic Arrogance" => "2"
      }
    end

    subject { Laracna::Scg::DeckPage.new url }

    its(:description) { is_expected.to eql "1st Place at StarCityGames.com Invitational Qualifier on 9/5/2015" }
    its(:name) { is_expected.to be_eql "Abzan Control" }
    its(:main) { is_expected.to be_eql main }
    its(:sideboard) { is_expected.to be_eql sideboard }

    its(:"attributes.keys.sort") { should be_eql attributes_list.sort }
  end

  context "with a invalid deck page" do
    let(:url) { "http://sales.starcitygames.com//deckdatabase/displaydeck.php?DeckID=86785" }

    subject { described_class.new url }

    its(:valid?) { is_expected.to be_falsy }

    context ".attributes" do
      subject { described_class.new(url).attributes }

      it { expect { subject }.to raise_error Laracna::InvalidPageError }
    end
  end
end
