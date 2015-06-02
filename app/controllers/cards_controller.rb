class CardsController < ApplicationController
  respond_to :json, only: [:index]

  def index
    @cards =  Orthanc.new(search_params).cards.limit(5);

    respond_with @cards
  end

  private

  def search_params
    params[:query].to_h.deep_symbolize_keys
  end
end
