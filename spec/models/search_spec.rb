require File.expand_path('spec/spec_helper')

describe Search do
  let(:params) { {} } 
  let(:search) { Search.new(params) }

  subject { search }
 
  its(:name) { should_not be_nil }

  describe ".execute" do
    subject { search.execute.to_a }

    context "with data" do
      let!(:card) { create(:card) }  
      let(:params) { {name: "Magmajet"} }
      
      it { should eq [card] }
    end

    context "without data" do
      it { should be_empty }
    end
  end
end
