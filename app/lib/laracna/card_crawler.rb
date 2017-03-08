require "./lib/laracna/laracna"

class CardCrawler
  def initialize(set)
    @set = set
  end

  def engine
    RepoWrapper.new @set
  end

  def persist!(model = Card)
    new = reprint = 0

    engine.attributes.map do |attrs|
      model.
        find_or_initialize_by(name: attrs["name"]).
        tap { |card| card.new_record? ? new += 1 : reprint += 1 }.
        update_attributes(attrs)
    end

    { novas: new, reprints: reprint }
  end
end
