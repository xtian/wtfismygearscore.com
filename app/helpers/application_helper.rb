module ApplicationHelper
  def async_javascript_include_tag(name, options = {})
    javascript_include_tag name, options.reverse_merge(
      'data-turbolinks-track' => 'reload',
      defer: true
    )
  end

  # Enables progressive rendering using `<link>` tags within the `<body>` after the content they style.
  # See: https://jakearchibald.com/2016/link-in-body/
  def async_stylesheet_link_tag(name, options = {})
    concat stylesheet_link_tag(name, options.reverse_merge('data-turbolinks-track' => 'reload'))
    content_tag :script, ' '
  end

  def page_title(page_title: nil, site_name: nil, subtitle: nil)
    [page_title, site_name, (subtitle unless page_title)].compact.join(' — ')
  end

  def link_to_character(*args)
    options = args.extract_options!
    string, character = args

    if character.nil?
      character = args.first
      string = character.name
    end

    css_class_name = character.class_name.parameterize.underscore.camelize(:lower)
    options[:class] = ["CharacterLink--#{css_class_name}", *options[:class]]
    link_to(string, character, options)
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
