class ApplicationController < ActionController::Base
  respond_to :json, :html

  protect_from_forgery
end
