class CardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  respond_to :json, only: [:index]

  def index
    @cards =  Orthanc.new(params[:query]).cards.page(params[:page]);

    respond_with @cards
  end
end
