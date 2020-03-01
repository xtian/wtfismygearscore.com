# typed: false
# frozen_string_literal: true

module ApplicationHelper
  # Outputs a `<script defer>` tag which executes in the order included in the
  # page after the DOM has been loaded.
  # @param name [String]
  # @param options [Hash]
  # @return [String]
  def async_javascript_include_tag(name, options = {})
    javascript_include_tag name, options.reverse_merge(defer: true)
  end

  # @return [String]
  def page_title(page_title: nil, site_name: nil, subtitle: nil)
    [page_title, site_name, (subtitle unless page_title)].compact.join(" — ")
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
