SELECT track_name, artist_name, streams
from tracks 
WHERE artist_name = 'Taylor Swift'
ORDER BY streams DESC
LIMIT 10;
