class CardsController < ApplicationController
  respond_to :json, only: [:index]

  def index
    if search_parms
      @cards =  Orthanc.new(search_parms.deep_symbolize_keys).cards
    else
      @cards = []
    end

    respond_with @cards
  end

  def show
    @card = Card.find(params[:id])
  end

  private

  def search_parms
    params.require(:query)
  end
end
