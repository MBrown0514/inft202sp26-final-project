SELECT artist_name, AVG(streams)
FROM tracks
GROUP BY artist_name
ORDER BY AVG(streams) DESC;
