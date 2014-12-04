class BasePresenter
  def self.map(collection)
    collection.map { |presenter| new(presenter) } 
  end 
end
