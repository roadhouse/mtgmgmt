class BasePresenter
  attr_accessor :subject

  def initialize(subject)
    @subject = subject
  end

  def self.map(collection)
    collection.map { |p| new(p) } 
  end 
end
