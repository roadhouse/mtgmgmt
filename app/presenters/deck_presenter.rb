class DeckPresenter < BasePresenter
  attr_accessor :deck

  delegate :name, :description, :quantity, to: :@deck

  delegate :by_manacost, :total_by_manacost, :total_by_type, :total_by_color, to: :@stats

  def initialize(deck = nil)
    @deck      = deck
    @main      = deck.main
    @sideboard = deck.sideboard

    @stats = DeckStats.new(deck.main)
  end

  def archeptype_deck
    DeckPresenter.new @deck.archeptype_deck
  end

  def percent_owned(user, part)
    user ? user.percent_from(card_pool(part).map {|i| i[:card]}).truncate : 0
  end

  def group_by_card_type(part)
    card_types = /Unknown|Land|Instant|Sorcery|Enchantment|Planeswalker|Creature|Artifact/
    data = card_pool(part).group_by { |card| (card[:card].ctype or "Unknown").match(card_types).to_s }.sort

    Hash[data]
  end

  def colors_list
    @deck.cards.map(&:colors).flatten.compact.uniq.map(&:downcase).sort.map do |color|
      classes = ["mtg"] + css_colors.fetch(color.to_sym)

      h.content_tag(:i, nil, class: classes)
    end
  end

  def css_colors
    {
      red: %w{mana-r},
      blue: %w{mana-u},
      black: %w{mana-b},
      green: %w{mana-g},
      white: %w{mana-w},
      colorless: %w{mana}
    }
  end

  def total_price
    @main.inject(0) { |total, card| total + card.try(:price).to_f }
  end

  def type_chart_data
    total_by_color
      .delete_if { |key,_| key == :colorless }
      .map do |pair|
      {
        value: pair.last,
        label: pair.first.to_s,
        color: colors.fetch(pair.first),
      }
    end.to_json.html_safe
  end

  def async_color
    total_by_color
      .delete_if { |key,_| key == :colorless }
      .map do |pair| { strokeColor: colors.fetch(pair.first) }
    end
  end

  def colors
    {
      black: "#424242",
      blue: "#82B1FF",
      red: "#FF8A80",
      white: "#fff8e1",
      green: "#B9F6CA"
    }
  end

  def first_hand
    @deck.main.map(&:name).shuffle![0..6]
  end

  def deck_list(part = :main)
    card_pool(part)
      .map { |entry| {copies: entry[:copies], name: entry[:card].name, id: entry[:card].id, image:entry[:card].image} }
  end

  private

  def pool(part)
    { main: @deck.main, sideboard: @deck.sideboard }.fetch(part)
  end

  def card_pool(part)
    @deck.list[part.to_s]
      .map { |entry| {copies: entry.last, card: Card.find_by_name(entry.first.gsub("Æther", "Aether").split("//").first.strip) || entry.first } }
      .each { |entry| raise Exception, "Invalid deck entry deck##{@deck.id}[#{part}] -> #{entry[:card]}" unless entry[:card].is_a?(Card) }
  end
end
