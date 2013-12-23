require "./app/presenters/base_presenter.rb"

describe BasePresenter do
  let(:model) { double("Model") }

  context ".new" do
    subject { described_class.new(model) }
    
    its(:subject) { should eq model }
  end

  context "#map" do
    subject { described_class.map [model] }  

    it { should be_a Array }
    it { subject.all? { |p| p.is_a? described_class } }
  end
end
