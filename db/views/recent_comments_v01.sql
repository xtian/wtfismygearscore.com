SELECT
  characters.class_name AS character_class,
  characters.name AS character_name,
  characters.realm AS character_realm,
  characters.region AS character_region,
  comments.created_at,
  comments.id AS comment_id,
  comments.poster_name
FROM comments
JOIN characters ON comments.character_id = characters.id
ORDER BY comments.created_at DESC
LIMIT 5;
