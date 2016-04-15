require "./lib/laracna/laracna"
require "mtg_sdk"
require "./spec/support/vcr"
require "rspec/its"

describe RepoWrapper, :vcr do
  let(:repo_wrapper) { described_class.new "soi" }
  let(:card_data) { repo_wrapper.repo.first.to_hash }

  context "#engine" do
    subject { repo_wrapper.repo }

    it { is_expected.to_not be_nil }
  end

  context "#normalize_data" do
    subject { repo_wrapper.normalize_data card_data }
    let(:original_types) { %w(manaCost multiverseid originalText imageUrl originalType) }
    let(:model_attributes) { %i(mana_cost multiverse_id original_text image original_type) }
    it { is_expected.to be_a Hash }

    its(:keys) { is_expected.to include(*model_attributes) }
    its(:keys) { is_expected.not_to include(*original_types) }
  end
end
