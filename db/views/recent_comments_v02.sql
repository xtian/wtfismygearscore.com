SELECT
  comments.class_name AS character_class,
  comments.name AS character_name,
  comments.realm AS character_realm,
  comments.region,
  comments.created_at,
  comments.id AS comment_id,
  comments.poster_name
FROM (
  SELECT
    comments.*,
    characters.class_name,
    characters.name,
    characters.realm,
    characters.region,
    row_number() OVER (PARTITION BY characters.region ORDER BY comments.created_at DESC)
  FROM comments
  JOIN characters ON comments.character_id = characters.id
) AS comments
WHERE comments.row_number < 6;
