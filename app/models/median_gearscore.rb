# typed: true
# frozen_string_literal: true

class MedianGearscore < ApplicationRecord
  validates :level, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :median_score, presence: true, numericality: true

  # Recalculates median score for given level
  # @return [void]
  def calculate
    result = self.class.find_by_sql(median_sql).first
    self.median_score = result.median_score
    save!
  end

  # @return [Float, Integer]
  def median_score
    super() || 0
  end

  private

  # http://okbob.blogspot.com/2009/11/aggregate-function-median-in-postgresql.html#c7074964960646383252
  def median_sql
    <<-SQL.strip_heredoc
      SELECT avg(score) AS median_score
      FROM (
        SELECT score, row_number() OVER (PARTITION BY level ORDER BY score DESC),
        (SELECT count(*) FROM #{from_clause})
        FROM #{from_clause}
      ) AS _ordered
      WHERE row_number = ceil((count::float8 - 1) / 2 + 1)
      OR row_number = floor((count::float8 - 1) / 2 + 1);
    SQL
  end

  def from_clause
    "#{Character.table_name} WHERE level = #{level}"
  end
end
