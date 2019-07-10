# typed: false
# frozen_string_literal: true

Fabricator(:median_gearscore) do
  level { rand(1..100) }
  median_score { rand(1..22_000) }
end
