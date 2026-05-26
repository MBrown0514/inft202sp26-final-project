SELECT artist_name, COUNT(*)
FROM tracks
GROUP BY artist_name
ORDER BY COUNT(*) DESC;
