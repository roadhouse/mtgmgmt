class CardsController < ApplicationController
  def index
    @q = Card.search(params[:q])
    @cards = @q.result
  end

  def show
    @card = Card.find(params[:id])
  end
end
