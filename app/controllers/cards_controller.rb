class CardsController < ApplicationController
  respond_to :json, only: [:index]

  def index
    @cards =  Orthanc.new(params[:query].to_s).cards.page(params[:page]);

    respond_with @cards
  end
end
