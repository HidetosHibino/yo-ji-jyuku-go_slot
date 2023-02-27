module ApplicationHelper
  def page_title(page_title = '')
    base_title = '🎰四字熟語スロット🎰'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
