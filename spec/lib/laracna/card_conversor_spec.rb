describe CardConversor do
  let(:card_data) { VCR.use_cassette("kaladesh-set") { MTG::Card.where(set: 'KLD').all } }
  let(:card_conversor) { described_class.new card_data.first }
  let(:model_attributes) { described_class::EQUIVALENT_NAMES.keys }
  let(:original_fields) { described_class::ATTRS_TO_DELETE }
  let(:original_types) { described_class::EQUIVALENT_NAMES.values }

  context "#normalize_data" do
    subject { card_conversor.normalize_data }

    it { is_expected.to be_a Hash }
    its(:keys) { is_expected.to include(*model_attributes) }
    its(:keys) { is_expected.not_to include(*original_types) }
  end

  context "#delete_fields" do
    subject { card_conversor.delete_fields }

    it { is_expected.to be_a Hash }
    its(:keys) { is_expected.not_to include(*original_fields) }
  end

  context '#convert' do
    subject { card_conversor.convert }

    it { is_expected.to be_a Hash }
    its(:keys) { is_expected.to include(*model_attributes) }
    its(:keys) { is_expected.not_to include(*original_types) }
    its(:keys) { is_expected.not_to include(*original_fields) }
  end
end
