require "./spec/support/vcr"
require 'ostruct'

require "./lib/app/laracna/card_crawler.rb"

describe CardCrawler, :vcr do
  let(:url) { "http://magiccards.info/query?q=%2B%2Be%3Ajou%2Fen&v=spoiler&s=issue" }

  subject { described_class.new(url) }

  context ".cards_attributes" do
  end

  context ".new_card_data" do
    subject { described_class.new(url).new_card_data(data) }

    context "parsing Creature data" do
      let(:data) do
        ["Aegis of the Gods",
         "Journey into Nyx",
         "Rare",
         "Enchantment Creature - Human Soldier 2/1,",
         "1W (2)",
         "You have hexproof. (You can't be the target of spells or abilities your opponents control.)",
         "Athreos cares little for the other gods' conflict with mortals. He is concerned only with safe passage for the dead.",
         "Illus. Yefim Kligerman",
         "/jou/en/1.html"]
      end


      its(:name) { should == "Aegis of the Gods"}
      its(:set) { should  == "Journey into Nyx" }
      its(:rarity) { should  == "Rare" }
      its(:card_type) { should  == "Enchantment Creature - Human Soldier" }
      its(:power) { should  == "2" }
      its(:thougness) { should  == "1" }
      its(:manacost) { should  == "1W" }
      its(:converted_manacost) { should  == "2" }
      its(:oracle_text) { should  == "You have hexproof. (You can't be the target of spells or abilities your opponents control.)" }
      its(:quote) { should  == "Athreos cares little for the other gods' conflict with mortals. He is concerned only with safe passage for the dead." }
      its(:illustrator) { should  == "Illus. Yefim Kligerman" }
    end

    context "parsing Land data" do
      let(:data) do
        ["Temple of Malady",
         "Journey into Nyx",
         "Rare",
         "Land,",
         "Temple of Malady enters the battlefield tapped.When Temple of Malady enters the battlefield, scry 1. (Look at the top card of your library. You may put that card on the bottom of your library.){T}: Add {B} or {G} to your mana pool.",
         "Illus. James Paick",
         "/jou/en/165.html"]
      end

      its(:name) { should == "Temple of Malady" }
      its(:set) { should  == "Journey into Nyx" }
      its(:rarity) { should  == "Rare" }
      its(:card_type) { should  == "Land" }
      its(:power) { should  == "" }
      its(:thougness) { should  == "" }
      its(:manacost) { should  == "" }
      its(:converted_manacost) { should  == "" }
      its(:oracle_text) { should  == "Temple of Malady enters the battlefield tapped.When Temple of Malady enters the battlefield, scry 1. (Look at the top card of your library. You may put that card on the bottom of your library.){T}: Add {B} or {G} to your mana pool." }
      its(:quote) { should  == "" }
      its(:illustrator) { should  == "Illus. James Paick" }
    end

    context "parsing Land data" do
      let(:data) do
        ["Mana Confluence",
         "Journey into Nyx",
         "Rare",
         "Land,",
         "{T}, Pay 1 life: Add one mana of any color to your mana pool.",
         "Five rivers encircle Theros, flowing with waters more ancient than the world itself.",
         "Illus. Richard Wright",
         "/jou/en/163.html"]
      end

      its(:name) { should == "Mana Confluence" }
      its(:set) { should  == "Journey into Nyx" }
      its(:rarity) { should  == "Rare" }
      its(:card_type) { should  == "Land" }
      its(:power) { should  == "" }
      its(:thougness) { should  == "" }
      its(:manacost) { should  == "" }
      its(:converted_manacost) { should  == "" }
      its(:oracle_text) { should  == "{T}, Pay 1 life: Add one mana of any color to your mana pool." }
      its(:quote) { should  == "Five rivers encircle Theros, flowing with waters more ancient than the world itself." }
      its(:illustrator) { should  == "Illus. Richard Wright" }
    end

    context "parsing Planeswalker data" do
      let(:data) do
        ["Ajani, Mentor of Heroes",
         "Journey into Nyx",
         "Mythic Rare",
         "Planeswalker -  Ajani (Loyalty: 4),",
         "3WG (5)",
         "+1: Distribute three +1/+1 counters among one, two, or three target creatures you control.+1: Look at the top four cards of your library. You may reveal an Aura, creature, or planeswalker card from among them and put it into your hand. Put the rest on the bottom of your library in any order.-8: You gain 100 life.",
         "Illus. Aaron Miller",
         "/jou/en/145.html"]
      end

      its(:name) { should == "Ajani, Mentor of Heroes" }
      its(:set) { should  == "Journey into Nyx" }
      its(:rarity) { should  == "Mythic Rare" }
      its(:card_type) { should  == "Planeswalker - Ajani" }
      its(:loyalty) { should  == "4" }
      its(:power) { should  == "" }
      its(:thougness) { should  == "" }
      its(:manacost) { should  == "3WG" }
      its(:converted_manacost) { should  == "5" }
      its(:oracle_text) { should  == "+1: Distribute three +1/+1 counters among one, two, or three target creatures you control.+1: Look at the top four cards of your library. You may reveal an Aura, creature, or planeswalker card from among them and put it into your hand. Put the rest on the bottom of your library in any order.-8: You gain 100 life." }
      its(:quote) { should  == "" }
      its(:illustrator) { should  == "Illus. Aaron Miller" }
    end
  end
end
