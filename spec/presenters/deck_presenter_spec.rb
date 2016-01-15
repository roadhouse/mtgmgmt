require 'spec_helper'

describe DeckPresenter do
  let(:deck) { create :deck }

  context ".percent_owned" do
    context 'when user not logged' do
      subject { described_class.new(deck).percent_owned nil, :main }

      it { is_expected.to be_equal 0 }
    end
  end
end
