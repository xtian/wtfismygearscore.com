# frozen_string_literal: true
module ApplicationHelper
  # Outputs a `<script defer>` tag which executes in the order included in the
  # page after the DOM has been loaded.
  # @param name [String]
  # @param options [Hash]
  # @return [String]
  def async_javascript_include_tag(name, options = {})
    javascript_include_tag name, options.reverse_merge(
      'data-turbolinks-track' => 'reload',
      defer: true
    )
  end

  # @param name [String]
  # @return [String]
  def stylesheet_link_tag(name, options = {})
    super(name, options.reverse_merge('data-turbolinks-track' => 'reload'))
  end

  # @return [String]
  def page_title(page_title: nil, site_name: nil, subtitle: nil)
    [page_title, site_name, (subtitle unless page_title)].compact.join(' — ')
  end

  # Outputs a `<link rel=subresource>` and `<link rel=preload>` which both
  # indicate that a resource is required for the current page. Both are needed
  # because `rel=subresource` is deprecated but `rel=preload` has limited
  # browser support.
  # @return [String] pair of `<link>` tags for preloading a resource
  def preload_link_tag(path)
    concat tag(:link, rel: 'subresource', href: path)
    tag(:link, rel: 'preload', href: path)
  end

  if Rails.env.test?
    # @param id [Symbol] unique element identifier
    # @return [String] data attribute identifier for tests
    def tid(id)
      "data-t-#{id}"
    end
  else
    # @return nil
    def tid(*); end
  end
end
