require "spec_helper"

describe CardParam do
  context ".params" do
    context "filter lands by default" do
      subject { described_class.new({}).params.to_sql }
      let(:sql_fragment) do
        %{"cards"."is_standard" = TRUE AND "cards"."set" != 'fake'}
      end

      it { is_expected.to eq sql_fragment }
    end
  end
end
