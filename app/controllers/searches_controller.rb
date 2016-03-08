class SearchesController < ApplicationController
  def top_cards
    @top_cards = Orthanc.new(params[:query]).top_cards
  end
end
