require "postgres_ext"

require_dependency "deck_param"
require_dependency "card_param"

class Orthanc
  def initialize(options)
    default_options = {
      limit: 10, 
      season: "BFZ-DTK-FRF-KTK-ORI",
      part: "main"
    }

    @options = default_options.merge param_builder(options)

    @card = CardParam.new(@options)
    @deck = DeckParam.new(@options)
  end

  def param_builder(str)
    fixed_params = str.gsub(": ", ":").split(" ")
    params = fixed_params.each_with_object({}) do |filter, query|
      params = filter.split(/:\s*/)
      
      if params.size > 1
        query[params.first.downcase.to_sym] = params.last.downcase.capitalize
      else
        query[:name] = query[:name].to_a << params.last
      end
    end 

    if params[:name]
      params.tap { |query| query[:name] = query[:name].join(' ') }
    else
      params
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
      .select("name, COUNT(decks.list->'main_cards') AS quantity")
      .group(@deck.name)
      .order("COUNT(decks.list->'main_cards') DESC")
      .where(@deck.params)
      .limit(@options.fetch(:limit))
  end
end
