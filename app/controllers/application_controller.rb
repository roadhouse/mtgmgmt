class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  respond_to :json, :html
  protect_from_forgery
  after_action :set_csrf_cookie_for_ng

  # see http://stackoverflow.com/questions/14734243/rails-csrf-protection-angular-js-protect-from-forgery-makes-me-to-log-out-on
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end
end
