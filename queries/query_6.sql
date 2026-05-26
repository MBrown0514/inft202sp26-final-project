SELECT artist_name, AVG(BPM), COUNT(*)
FROM tracks
JOIN track_features
ON tracks.track_id = track_features.track_id
GROUP BY artist_name
ORDER BY AVG(BPM) DESC;
