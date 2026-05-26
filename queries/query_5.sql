SELECT artist_name, track_name, streams, bpm, song_key, mode 
FROM tracks
JOIN track_features
ON tracks.track_id = track_features.track_id
WHERE artist_name = 'The Weeknd';
