require "./lib/laracna/laracna"

class CardCrawler
  def initialize(set)
    @set = set
  end

  def engine
    RepoWrapper.new @set
  end

  def persist!(model = Card)
    engine.attributes.map do |attrs|
      card = model.new attrs

      if card.valid?
        card.save!(attrs)
        "Card #{card.name} saved"
      else
        "Card #{card.name} not saved"
      end
    end
  end
end
