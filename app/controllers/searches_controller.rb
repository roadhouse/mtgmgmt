class SearchesController < ApplicationController
  def index
    @search = Search.new
  end

  def create
    search = Search.new(params[:search]).execute
    @cards = SearchesPresenter.map(search)
  end
end
