class ListsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]
  respond_to :json, only: [:show]

  def show
    @inventories = Orthanc.new("list:#{params[:name]} #{params[:query]}").from_user User.find(params[:user_id])
  end
end
