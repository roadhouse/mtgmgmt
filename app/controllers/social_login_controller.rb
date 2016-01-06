class SocialLoginController < Devise::OmniauthCallbacksController
  def facebook
    sign_in_and_redirect User.from_omniauth(request.env["omniauth.auth"])
  end
end
