class DecksController < ApplicationController
  def index
    @decks = Deck.all.order(created_at: :desc).page params[:page]
    @presenter = DeckPresenter.new(@decks)
    @orthanc = Orthanc.new

    respond_with(@decks)
  end

  def show
    @deck = Deck.find(params[:id])

    respond_with(@deck)
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

  private
  
  def deck_params
    params.require(:deck).permit(:name, :description, :card_list)
  end
end
