Fabricator(:comment) do
  body 'hi'
  poster_ip_address { Array.new(4).map { rand(256) }.join('.') }
end
