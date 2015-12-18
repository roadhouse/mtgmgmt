require "spec_helper"

describe CardParam do
  context ".params" do
    context "filter lands by default" do
      subject { described_class.new({}).params.to_sql }
      let(:sql_fragment) do
        %{"cards"."is_standard" = 't' AND "cards"."set" != 'fake' AND "cards"."ctypes" NOT IN ('{Land}')}
      end

      it { is_expected.to eq sql_fragment }
    end
  end
end
