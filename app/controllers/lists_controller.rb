class ListsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  respond_to :json, only: [:show]

  def show
    @inventories = Orthanc.new("list:#{params[:name]} #{params[:query]}").from_user user
  end

  private

  def user
    User.find params[:user_id]
  end
end
