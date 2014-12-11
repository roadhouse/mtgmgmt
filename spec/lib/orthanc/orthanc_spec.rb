require 'spec_helper'


describe Orthanc do
  # before(:all) do 
    # create_list(:deck, 2)
  # end

  let(:orthanc) { described_class.new({}) }

  subject { orthanc.top_decks }

  it { is_expected.to_not be_nil }
end
