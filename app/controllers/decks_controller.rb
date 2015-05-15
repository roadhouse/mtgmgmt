class DecksController < ApplicationController
  def index
    @presenter = MetaGamePresenter.new
  end

  def show
    @deck = DeckPresenter.new Deck.find(params[:id])
  end

  def new
    @deck = DeckForm.new(Deck.new)
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def create
    @deck = Deck.new

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

  def search
    @decks = Deck.none

    if params[:search]
      @decks = DeckPresenter.map Deck.per_name(params[:search][:query]).limit(10)
    end
  end

  def print
    @deck = Deck.find(params[:id])
  end

  private
  
  def deck_params
    params.require(:deck).permit(:name, :description, :card_list)
  end
end
