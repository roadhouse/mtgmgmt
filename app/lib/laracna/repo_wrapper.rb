class RepoWrapper
  def initialize(set)
    @set = set
  end

  def api_data
    MTG::Card.where(set: @set).all
  end

  def attributes
    api_data.map { |data| CardConversor.convert data }
  end
end
