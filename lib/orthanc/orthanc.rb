require 'postgres_ext'

require 'deck_param'
require 'card_param'

#queries using arel and extract reports
# PARAMS: {color: [:w|:r|:c|:b|:a|:g], type: [:a|:l|:i|:s|:c|:p], name: "name", oracle: "haste"}
class Orthanc
  def initialize(options)
    default_options = {
      limit: 10, 
      season: "BNG-DTK-FRF-JOU-KTK-M15-THS"
    }

    @options = default_options.merge options

    @card = CardParam.new(@options)
    @deck = DeckParam.new(@options)
  end

  #basic card search using CardParam params as filter
  def cards
    @options.empty? ? @card.model.none : @card.model.where(@card.params)
  end

  #top cards played in standard
  #DEFAULT: looking in main deck and ignore land cards
  def top_cards 
    @card.model
      .with(cards_on_deck: @deck.cards_on_deck, card_quantity: card_quantity)
      .select("cards.*", "(cast(card_quantity.quantity as float) / cast((#{total_decks.to_sql}) as float)) * 100 AS presence")
      .joins("INNER JOIN card_quantity ON card_quantity.name = cards.name")
      .where(@card.params)
      .order("card_quantity.quantity DESC")
      .limit(10)
  end

  #top cards played in standard, in the last season
  def top_decks
    @deck.model
      .select(@deck.name, @deck.name_quantity)
      .group(@deck.name)
      .order(Arel::Nodes::Descending.new(@deck.name.count))
      .where(@deck.params)
      .limit(@options.fetch(:limit))
  end

  private

  def total_decks
    @deck.model.select @deck.name_quantity
  end

  def card_quantity
    table = Arel::Table.new(:cards_on_deck)
    table
      .project(table[:name], table[:name].count.as('quantity'))
      .group(table[:name])
  end
end
