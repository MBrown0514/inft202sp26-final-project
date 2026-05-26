-- Spotify Most Streamed Songs: Table Creation Worksheet
-- Run your finished SQL while connected to the PostgreSQL database named final.
--
-- Adminer login:
-- System: PostgreSQL
-- Server: postgres
-- Username: postgres
-- Password: postgres
-- Database: final

-- Goal:
-- Create two related tables:
--
-- 1. tracks
--    One row = one song/track.
--    Suggested columns:
--    - track_id
--    - track_name
--    - artist_name
--    - artist_count
--    - released_year
--    - released_month
--    - released_day
--    - streams
--    - cover_url
--
-- 2. track_features
--    One row = the playlist/chart/audio feature details for one track.
--    Suggested columns:
--    - feature_id
--    - track_id
--    - in_spotify_playlists
--    - in_spotify_charts
--    - in_apple_playlists
--    - in_apple_charts
--    - in_deezer_playlists
--    - in_deezer_charts
--    - in_shazam_charts
--    - bpm
--    - song_key
--    - mode
--    - danceability_percent
--    - valence_percent
--    - energy_percent
--    - acousticness_percent
--    - instrumentalness_percent
--    - liveness_percent
--    - speechiness_percent

-- Step 1:
-- Drop the tables if they already exist.
-- Remember: drop the table with the foreign key first, then the table it points to.


-- Step 2:
-- Create the tracks table.
-- Remember to include:
-- - a primary key
-- - useful NOT NULL rules
-- - a large enough number type for streams


-- Step 3:
-- Create the track_features table.
-- Remember to include:
-- - a primary key
-- - track_id
-- - a foreign key that connects track_features.track_id to tracks.track_id

