class SearchesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:top_cards]

  def top_cards
    @top_cards = Orthanc.new(params[:query]).top_cards
  end
end
