class ListsController < ApplicationController
  respond_to :json, only: [:show]

  def show
    @inventories = Orthanc.new(params[:query]).from_user User.find(params[:user_id])
  end
end
