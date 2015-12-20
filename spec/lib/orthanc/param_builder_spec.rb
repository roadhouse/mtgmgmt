require "spec_helper"

describe ParamBuilder do
  context ".param_builder" do
    subject { ParamBuilder.params(filter_string) }

    context "with only arbitrary string" do
      let(:filter_string) { "brimaz" }

      it { is_expected.to eq({name: "brimaz"}) }
    end

    context "with only arbitrary string with spaces" do
      let(:filter_string) { "elmo dos de" }

      it { is_expected.to eq({name: "elmo dos de"}) }
    end

    context "with a token filter" do
      let(:filter_string) { "brimaz Type:creature" }

      it { is_expected.to eq({type: "Creature", name: "brimaz"}) }
    end

    context "ignoring space after filter separator" do
      let(:filter_string) { "brimaz Type: creature" }

      it { is_expected.to eq({type: "Creature", name: "brimaz"}) }
    end
  end
end
