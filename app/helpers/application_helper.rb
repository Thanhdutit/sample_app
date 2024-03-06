module ApplicationHelper
  def full_title page_title = ""
    base_title = I18n.t("titles.base")
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
