SELECT artist_name, track_name, streams
FROM tracks
WHERE artist_name = 'The Weeknd'
ORDER BY streams DESC
LIMIT 3;
