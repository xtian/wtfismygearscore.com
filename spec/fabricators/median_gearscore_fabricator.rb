# frozen_string_literal: true

Fabricator(:median_gearscore) do
  level { rand(100) + 1 }
  median_score { rand(22_000) + 1 }
end
