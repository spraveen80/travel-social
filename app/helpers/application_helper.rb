# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Return a title on a per-page basis
  def title
    site_title = "Travel Assistance"
    if @page_title.nil?
      site_title
    else
      "#{site_title} | #{h(@page_title)}"
    end
  end
end
