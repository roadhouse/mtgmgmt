class DecksController < ApplicationController
  respond_to :json, only: [:create]
  skip_before_action :authenticate_user!#, only: [:index, :create, :new]

  def index
    @presenter = MetaGamePresenter.new
  end

  def show
    @deck = DeckPresenter.new Deck.find(params[:id])
  end

  def new

  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def create
    @deck = DeckPresenter.new Deck.new.add_card_entries(params.to_unsafe_hash.fetch("deck"))
    respond_with @deck
  end

  def update
    @deck = Deck.find(params[:id])

    respond_with @deck if @deck.update_attributes(deck_params)
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

    @cards = {main: @deck.main, sideboard: @deck.sideboard}.fetch(params[:part].to_sym)

    render layout: "print"
  end

  def cockatrice
    deck = Deck.find(params[:id])

    send_file CockatriceBuilder.new(deck).file, filename: deck.name + ".cod"
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :description, :list, :deck)
  end
end
