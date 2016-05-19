module ApplicationHelper
  def async_javascript_include_tag(name, options = {})
    javascript_include_tag name, options.reverse_merge(
      'data-turbolinks-track' => 'reload',
      defer: true
    )
  end

  def page_title(options = {})
    app_name = options[:app_name]

    if content_for?(:page_title)
      [content_for(:page_title), app_name].join(' — ')
    else
      app_name
    end
  end

  if Rails.env.test?
    def tid(id)
      "data-t-#{id}"
    end
  else
    def tid(*); end
  end
end
