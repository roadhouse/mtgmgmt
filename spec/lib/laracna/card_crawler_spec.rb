describe CardCrawler do
  context "engine" do
    subject { described_class.new("soi").engine }

    it { is_expected.to_not be_nil }
  end
end
