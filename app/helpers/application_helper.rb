module ApplicationHelper
  def render_ga
    render "shared/ga" if Rails.env.production?
  end

  def navigation_item(name, url)
    # active_class = current_page?(url) ? {class: "active"} : {}

    link_to name, url, class: "mdl-navigation__link"
  end
end
