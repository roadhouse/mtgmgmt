class DeckParam
  def initialize(options)
    @options = options 
  end

  def model
    Deck
  end

  def table
    model.arel_table
  end

  def id
    table[:id]
  end

  def name
    table[:name]
  end

  def season
    table[:season]
  end
end
