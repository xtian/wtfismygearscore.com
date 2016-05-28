module ApplicationHelper
  def async_javascript_include_tag(name, options = {})
    javascript_include_tag name, options.reverse_merge(
      'data-turbolinks-track' => 'reload',
      defer: true
    )
  end

  def page_title(site_name: nil)
    [content_for(:page_title), site_name].compact.join(' — ')
  end

  if Rails.env.test?
    def tid(id)
      "data-t-#{id}"
    end
  else
    def tid(*); end
  end
end
