class SearchesController < ApplicationController
  def top_cards
    @top_cards = Orthanc.new("").top_cards
  end
end
