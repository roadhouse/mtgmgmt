require 'spec_helper'

describe DeckParam do
  context "#season_is('season')" do
    subject { described_class.new({}).season_is("season").to_sql }

    it { is_expected.to eq %{"decks"."season" = 'season'} }
  end

  context "#name_quantity" do
    subject { described_class.new({}).name_quantity.to_sql }

    it { is_expected.to eq %{COUNT("decks"."name") AS quantity} }
  end

  context "#total_decks" do
    subject { described_class.new({}).total_decks.to_sql }

    it { is_expected.to eq %{SELECT COUNT("decks"."name") AS quantity FROM "decks"} }
  end

  context "#cards_on_deck" do
    let(:sql_output) { %{SELECT jsonb_object_keys(list->'main') AS name FROM "decks" WHERE "decks"."season" = 'season'} }

    subject { described_class.new({season: "season"}).cards_on_deck.to_sql }

    it { is_expected.to eq sql_output }
  end

  context "#params" do
    subject { described_class.new(filter_params).params }

    context "with season parameter = 'season'" do
      let(:filter_params) { {season: "season"} }

      its(:to_sql) { is_expected.to eq %{"decks"."season" = 'season'} }
    end

    context "without season parameter" do
      let(:filter_params) { {} }

      it { expect { subject }.to raise_error KeyError }
    end
  end
end
