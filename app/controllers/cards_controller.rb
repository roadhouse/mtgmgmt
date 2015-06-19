class CardsController < ApplicationController
  respond_to :json, only: [:index]

  def index
    @cards =  Orthanc.new(params[:query].to_s).cards.limit(5);

    respond_with @cards
  end

  private

  def search_params
    query = params[:query]

    query ? query.permit(:name).deep_symbolize_keys : {} 
  end

  def parse_params(params)
    params.to_s.split(" ").inject({}) do |m,v|
      p = v.split(":")
      m[p.first.to_sym] = %w(name oracle).include?(p.first) ? p.last : p.to_sym
      m
    end
  end
end
