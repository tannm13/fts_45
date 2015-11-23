module ApplicationHelper
  def full_title page_tile = ""
    base_title = t "base_title"
    if page_tile.empty?
      base_title
    else
      "#{page_tile} || #{base_title}"
    end
  end
end
