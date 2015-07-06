class BasePresenter
  def initialize(model)
    @model = model
  end

  def self.map(collection)
    collection.map { |presenter| self.send(:new,presenter) } 
  end 

  def h
    ApplicationController.helpers
  end
end
