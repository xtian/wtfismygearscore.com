# frozen_string_literal: true
module ApplicationHelper
  def async_javascript_include_tag(name, options = {})
    javascript_include_tag name, options.reverse_merge(
      'data-turbolinks-track' => 'reload',
      defer: true
    )
  end

  def stylesheet_link_tag(name, options = {})
    super(name, options.reverse_merge('data-turbolinks-track' => 'reload'))
  end

  def page_title(page_title: nil, site_name: nil, subtitle: nil)
    [page_title, site_name, (subtitle unless page_title)].compact.join(' — ')
  end

  # `rel=subresource` and `rel=preload` both indicate that a resource is required for the current page.
  # Both are needed because `rel=subresource` is deprecated but `rel=preload` has limited browser support.
  def preload_link_tag(path)
    concat tag(:link, rel: 'subresource', href: path)
    tag(:link, rel: 'preload', href: path)
  end

  if Rails.env.test?
    def tid(id)
      "data-t-#{id}"
    end
  else
    def tid(*); end
  end
end
