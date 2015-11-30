class CardsController < ApplicationController
  respond_to :json, only: [:index]

  def index
    @cards =  Orthanc.new(params[:query].to_s).cards.limit(10);

    respond_with @cards
  end
end
