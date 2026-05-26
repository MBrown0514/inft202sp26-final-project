SELECT artist_name, AVG(streams)
FROM tracks
GROUP BY artist_name 
HAVING AVG(streams) > 1000000000
ORDER BY AVG(streams) DESC;
