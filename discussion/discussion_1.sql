SELECT artist_name, SUM(streams) AS total_streams
FROM tracks
GROUP BY artist_name
HAVING SUM(streams) IS NOT NULL
ORDER BY SUM(streams) DESC
LIMIT 10;
