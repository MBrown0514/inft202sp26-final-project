-- Spotify Most Streamed Songs: Import Helper
-- Run this in Beekeeper Studio while connected to the PostgreSQL database named final.
--
-- This file first loads the original CSV into a temporary staging table.
-- Then it copies the useful columns into your tracks and track_features tables.
--
-- The Docker PostgreSQL container sees this project folder at /project.

DROP TABLE IF EXISTS spotify_raw;

CREATE TEMP TABLE spotify_raw (
    raw_id SERIAL PRIMARY KEY,
    track_name TEXT,
    "artist(s)_name" TEXT,
    artist_count TEXT,
    released_year TEXT,
    released_month TEXT,
    released_day TEXT,
    in_spotify_playlists TEXT,
    in_spotify_charts TEXT,
    streams TEXT,
    in_apple_playlists TEXT,
    in_apple_charts TEXT,
    in_deezer_playlists TEXT,
    in_deezer_charts TEXT,
    in_shazam_charts TEXT,
    bpm TEXT,
    key TEXT,
    mode TEXT,
    "danceability_%" TEXT,
    "valence_%" TEXT,
    "energy_%" TEXT,
    "acousticness_%" TEXT,
    "instrumentalness_%" TEXT,
    "liveness_%" TEXT,
    "speechiness_%" TEXT,
    cover_url TEXT
);

COPY spotify_raw (
    track_name,
    "artist(s)_name",
    artist_count,
    released_year,
    released_month,
    released_day,
    in_spotify_playlists,
    in_spotify_charts,
    streams,
    in_apple_playlists,
    in_apple_charts,
    in_deezer_playlists,
    in_deezer_charts,
    in_shazam_charts,
    bpm,
    key,
    mode,
    "danceability_%",
    "valence_%",
    "energy_%",
    "acousticness_%",
    "instrumentalness_%",
    "liveness_%",
    "speechiness_%",
    cover_url
)
FROM '/project/Spotify Most Streamed Songs.csv'
DELIMITER ','
CSV HEADER;

DELETE FROM track_features;
DELETE FROM tracks;

INSERT INTO tracks (
    track_id,
    track_name,
    artist_name,
    release_year,
    release_month,
    release_day,
    streams
)
SELECT
    raw_id,
    track_name,
    "artist(s)_name",
    NULLIF(released_year, '')::INTEGER,
    released_month,
    NULLIF(released_day, '')::INTEGER,
    CASE
        WHEN streams ~ '^[0-9]+$' THEN streams::NUMERIC
        ELSE NULL
    END
FROM spotify_raw;

INSERT INTO track_features (
    feature_id,
    track_id,
    in_spotify_playlists,
    in_spotify_charts,
    in_apple_charts,
    in_apple_playlists,
    in_deezer_playlists,
    in_deezer_charts,
    bpm,
    song_key,
    mode
)
SELECT
    raw_id,
    raw_id,
    NULLIF(REPLACE(in_spotify_playlists, ',', ''), '')::INTEGER,
    NULLIF(REPLACE(in_spotify_charts, ',', ''), '')::INTEGER,
    NULLIF(REPLACE(in_apple_charts, ',', ''), '')::INTEGER,
    NULLIF(REPLACE(in_apple_playlists, ',', ''), '')::INTEGER,
    NULLIF(REPLACE(in_deezer_playlists, ',', ''), '')::INTEGER,
    NULLIF(REPLACE(in_deezer_charts, ',', ''), '')::INTEGER,
    NULLIF(REPLACE(bpm, ',', ''), '')::INTEGER,
    NULLIF(key, ''),
    mode
FROM spotify_raw;

-- After the import finishes, run these quick checks:
-- SELECT COUNT(*) FROM tracks;
-- SELECT COUNT(*) FROM track_features;
