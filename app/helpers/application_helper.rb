module ApplicationHelper
  def page_title(options = {})
    app_name = options[:app_name]

    if content_for?(:page_title)
      [content_for(:page_title), app_name].join(' — ')
    else
      app_name
    end
  end
end
