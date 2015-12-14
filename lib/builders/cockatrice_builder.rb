class CockatriceBuilder
  # temp_file  = Tempfile.new(deck.name)
  # temp_file.open { |f| f.write(output) }
  def initialize(deck)
    @deck = deck
  end

  def engine
    Nokogiri::XML::Builder
  end

  def format
    engine.new do |xml|
      xml.cockatrice_deck(version: 1) do
        xml.deckname @deck.name
        xml.comments @deck.description

        xml.zone(name: "main") do
          @deck.list["main"].each_pair do |card, copies| 
            xml.send(:card, card: card, number: copies)
          end
        end

        xml.zone(name: "side") do
          @deck.list["sideboard"].each_pair do |card, copies| 
            xml.send(:card, card: card, number: copies)
          end
        end
      end
    end
  end

  def output
    format.to_xml
  end
  
  def file
    Tempfile.new([@deck.name, '.cod']).tap do |file|
      file.write(output)
      file.rewind
    end
  end
end
