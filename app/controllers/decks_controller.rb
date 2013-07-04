class DecksController < ApplicationController
  def index
    @decks = Deck.all

    respond_with(@decks)
  end

  def show
    @deck = Deck.find(params[:id])

    respond_with(@deck)
  end

  # deck: {
    # name: "naya blitz",
    # description: "bla",
    # card_list: "4 tragtusk\n10 forest"
  # }

  def new
    @deck = Deck.new

    respond_with(@deck)
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def create
    @deck = Deck.new(params[:deck])

    respond_with(@deck)
  end

  def update
    @deck = Deck.find(params[:id])

    respond_with(@deck.update_attributes(params[:deck]))
  end

  def destroy
    @deck = Deck.find(params[:id])

    respond_with(@deck.destroy)
  end
end
