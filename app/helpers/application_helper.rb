module ApplicationHelper
  def current_user
    User.first
  end

  def render_ga
    render "shared/ga" if Rails.env.production?
  end
end
