require "spec_helper"

describe CardParam do
  context ".params" do
    context "filter lands by default" do
      subject { described_class.new({}).params.to_sql }

      it { is_expected.to eq %{"cards"."ctypes" NOT IN ('{Land}')} }
    end
  end
end
