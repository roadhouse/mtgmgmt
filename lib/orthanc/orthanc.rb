require 'postgres_ext'

require 'deck_param'
require 'card_param'

#queries using arel and extract reports
# PARAMS: {color: [:w|:r|:c|:b|:a|:g], type: [:a|:l|:i|:s|:c|:p], name: "name", oracle: "haste"}
class Orthanc
  def initialize(options)
    default_options = {
      limit: 10, 
      season: "BNG-DTK-FRF-JOU-KTK-M15-THS",
      part: "main"
    }

    @options = default_options.merge param_builder(options)

    @card = CardParam.new(@options)
    @deck = DeckParam.new(@options)
  end

  def param_builder(str)
    str.split(" ").each_with_object({}) do |filter, query|
      params = filter.split(":")
      
      if params.size > 1
        query[params.first.downcase.to_sym] = params.last.capitalize
      else
        query[:name] = params.last
      end
    end
  end

  #basic card search using CardParam params as filter
  def cards
    @options.empty? ? @card.table.none : @card.table.where(@card.params)
  end

  #top cards played in standard
  #DEFAULT: looking in main deck and ignore land cards
  def top_cards 
    @card.table
      .with(cards_on_deck: @deck.cards_on_deck, card_quantity: @deck.card_quantity)
      .select(@card.all_fields, "(cast(card_quantity.quantity as float) / cast((#{@deck.total_decks.to_sql}) as float)) * 100 AS presence")
      .joins("INNER JOIN card_quantity ON card_quantity.name = cards.name")
      .where(@card.params)
      .order("card_quantity.quantity DESC")
      .limit(@options.fetch(:limit))
  end

  #top cards played in standard, in the last season
  def top_decks
    @deck.table
      .select(@deck.name, @deck.name_quantity)
      .group(@deck.name)
      .order(Arel::Nodes::Descending.new(@deck.name_count))
      .where(@deck.params)
      .limit(@options.fetch(:limit))
  end
end
