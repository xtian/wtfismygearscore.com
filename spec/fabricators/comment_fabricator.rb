# frozen_string_literal: true

Fabricator(:comment) do
  body "hi"
  character
  poster_ip_address { Array.new(4).map { rand(256) }.join(".") }
end
