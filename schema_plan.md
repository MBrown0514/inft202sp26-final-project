# Schema Plan: Spotify Most Streamed Songs

## Dataset Focus

The project will focus on artists and songs in the Spotify most-streamed songs dataset. The original CSV has one row per track, but the database will split the data into two related tables so we can practice using primary keys, foreign keys, and joins.

## Table 1: `tracks`

One row in `tracks` represents one song/track.

| Column | Suggested type | Notes |
|---|---|---|
| `track_id` | `INTEGER` | Primary key. This will be a generated ID because the CSV does not include a clean unique ID. |
| `track_name` | `TEXT` | Song title. |
| `artist_name` | `TEXT` | Artist name text from the original `artist(s)_name` column. This may contain multiple artist names separated by commas. |
| `artist_count` | `INTEGER` | Number of credited artists. |
| `released_year` | `INTEGER` | Release year. Useful for grouping and filtering. |
| `released_month` | `INTEGER` | Release month. |
| `released_day` | `INTEGER` | Release day. |
| `streams` | `BIGINT` or `NUMERIC` | Spotify streams can be very large, so this should not be a small integer type. |
| `cover_url` | `TEXT` | Cover image URL. Some rows are missing this or say `Not Found`. |

Suggested key:

- Primary key: `track_id`

## Table 2: `track_features`

One row in `track_features` represents the chart, playlist, and audio feature details for one track.

| Column | Suggested type | Notes |
|---|---|---|
| `feature_id` | `INTEGER` | Primary key for the feature row. |
| `track_id` | `INTEGER` | Foreign key that connects this row back to `tracks.track_id`. |
| `in_spotify_playlists` | `INTEGER` | Number of Spotify playlists containing the track. |
| `in_spotify_charts` | `INTEGER` | Spotify chart count/ranking indicator from the CSV. |
| `in_apple_playlists` | `INTEGER` | Apple playlist count. |
| `in_apple_charts` | `INTEGER` | Apple chart count/ranking indicator. |
| `in_deezer_playlists` | `INTEGER` | Deezer playlist count. |
| `in_deezer_charts` | `INTEGER` | Deezer chart count/ranking indicator. |
| `in_shazam_charts` | `INTEGER` | Shazam chart value. Some rows are blank, so this may need to allow null values. |
| `bpm` | `INTEGER` | Beats per minute. |
| `song_key` | `TEXT` | Musical key. Renamed from `key` because `key` can be confusing in SQL/database vocabulary. Some rows are blank. |
| `mode` | `TEXT` | Major or Minor. |
| `danceability_percent` | `INTEGER` | Danceability percentage. Renamed from `danceability_%` for easier SQL use. |
| `valence_percent` | `INTEGER` | Valence percentage. |
| `energy_percent` | `INTEGER` | Energy percentage. |
| `acousticness_percent` | `INTEGER` | Acousticness percentage. |
| `instrumentalness_percent` | `INTEGER` | Instrumentalness percentage. |
| `liveness_percent` | `INTEGER` | Liveness percentage. |
| `speechiness_percent` | `INTEGER` | Speechiness percentage. |

Suggested keys:

- Primary key: `feature_id`
- Foreign key: `track_id`, which should point to `tracks(track_id)`

## Relationship

The two tables connect through `track_id`:

`tracks.track_id` -> `track_features.track_id`

In plain language: every row in `track_features` belongs to one row in `tracks`.

## Columns to Rename or Clean

The original CSV column names include characters that are awkward in SQL, so the database should use cleaner names:

| Original CSV column | Database column |
|---|---|
| `artist(s)_name` | `artist_name` |
| `key` | `song_key` |
| `danceability_%` | `danceability_percent` |
| `valence_%` | `valence_percent` |
| `energy_%` | `energy_percent` |
| `acousticness_%` | `acousticness_percent` |
| `instrumentalness_%` | `instrumentalness_percent` |
| `liveness_%` | `liveness_percent` |
| `speechiness_%` | `speechiness_percent` |

## Data Notes

- Some values in `in_shazam_charts`, `song_key`, and `cover_url` are missing.
- `streams` has one value that did not parse cleanly as a number during exploration, so it may need cleanup before import.
- `track_name` alone should not be used as a primary key because a few track names repeat.
- The artist field is useful for this project, but it is not fully normalized because some songs list multiple artists in a single text field.
