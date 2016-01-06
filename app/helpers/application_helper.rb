module ApplicationHelper
  def render_ga
    render "shared/ga" if Rails.env.production?
  end

  def navigation_item(name, url)
    active_class = current_page?(url) ? {class: "active"} : {}

    content_tag(:li, active_class) { link_to name, url }
  end
end
