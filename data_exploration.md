# Data Exploration: Spotify Most Streamed Songs and Artists of 2023

## File Reviewed

### `Spotify Most Streamed Songs.csv`

One row appears to represent one Spotify track/song, including the artist name, release date parts, streaming count, playlist/chart presence across several platforms, and audio features such as BPM, key, mode, danceability, energy, and acousticness.

The file has:

- 953 rows
- 25 columns
- 943 unique track names
- 645 unique artist name values

## Sample Rows

| track_name | artist(s)_name | released_year | streams | bpm | key | mode | danceability_% | energy_% |
|---|---|---:|---:|---:|---|---|---:|---:|
| Seven (feat. Latto) (Explicit Ver.) | Latto, Jung Kook | 2023 | 141381703 | 125 | B | Major | 80 | 83 |
| LALA | Myke Towers | 2023 | 133716286 | 92 | C# | Major | 71 | 74 |
| vampire | Olivia Rodrigo | 2023 | 140003974 | 138 | F | Major | 51 | 53 |
| Cruel Summer | Taylor Swift | 2019 | 800840817 | 170 | A | Major | 55 | 72 |
| WHERE SHE GOES | Bad Bunny | 2023 | 303236322 | 144 | A | Minor | 65 | 80 |

## Important Columns

| Column | What it appears to mean | Possible PostgreSQL type |
|---|---|---|
| `track_name` | Song title | `TEXT` |
| `artist(s)_name` | Artist or comma-separated list of artists | `TEXT` |
| `artist_count` | Number of artists credited on the song | `INTEGER` |
| `released_year`, `released_month`, `released_day` | Release date pieces | `INTEGER`, or combined into a `DATE` later |
| `streams` | Number of Spotify streams | `BIGINT` or `NUMERIC` |
| `in_spotify_playlists` | Number of Spotify playlists containing the track | `INTEGER` |
| `in_spotify_charts` | Spotify chart presence/rank count indicator | `INTEGER` |
| `in_apple_playlists`, `in_apple_charts` | Apple playlist/chart information | `INTEGER` |
| `in_deezer_playlists`, `in_deezer_charts` | Deezer playlist/chart information | `INTEGER` |
| `in_shazam_charts` | Shazam chart information | `INTEGER` |
| `bpm` | Beats per minute | `INTEGER` |
| `key` | Musical key | `TEXT` |
| `mode` | Major or minor | `TEXT` |
| `danceability_%`, `valence_%`, `energy_%`, `acousticness_%`, `instrumentalness_%`, `liveness_%`, `speechiness_%` | Audio feature percentages | `INTEGER` or `NUMERIC` |
| `cover_url` | Album/track cover image URL | `TEXT` |

## Data Quality Notes

- `in_shazam_charts` has 50 blank values.
- `key` has 95 blank values.
- `cover_url` is missing or marked `Not Found` for 225 rows.
- `streams` has 1 value that did not parse cleanly as a number during exploration.
- `track_name` is not fully unique: there are 953 rows but 943 unique track names.
- `artist(s)_name` sometimes contains multiple artists in one field, such as `Latto, Jung Kook`.
- There is no obvious ID column in the CSV, so the database may need a generated ID column.

## Numeric Ranges

| Column | Minimum | Maximum | Average |
|---|---:|---:|---:|
| `artist_count` | 1 | 8 | 1.6 |
| `released_year` | 1930 | 2023 | 2018.2 |
| `streams` | 2,762 | 3,703,895,074 | 514,137,424.9 |
| `in_spotify_playlists` | 31 | 52,898 | 5,200.1 |
| `in_spotify_charts` | 0 | 147 | 12.0 |
| `bpm` | 65 | 206 | 122.5 |
| `danceability_%` | 23 | 96 | 67.0 |
| `energy_%` | 9 | 97 | 64.3 |

## Common Categories

### Most common artists

| Artist | Row count |
|---|---:|
| Taylor Swift | 34 |
| The Weeknd | 22 |
| Bad Bunny | 19 |
| SZA | 19 |
| Harry Styles | 17 |

### Most common release years

| Year | Row count |
|---|---:|
| 2022 | 402 |
| 2023 | 175 |
| 2021 | 119 |
| 2020 | 37 |
| 2019 | 36 |

### Other useful categories

- `mode`: 550 Major songs and 403 Minor songs
- `artist_count`: 587 solo-artist tracks, 254 two-artist tracks, and fewer rows with larger collaborations
- `key`: many values such as C#, G, G#, F, B, D, and A, with 95 blanks

## Candidate Keys and Relationships

There is no existing primary key column in the CSV.

Possible primary key approach:

- Add a generated `track_id` for each song row.

Possible table split ideas:

- A `tracks` table for song identity and release information.
- A related table for chart/playlist numbers and audio features, connected back to `tracks` by `track_id`.
- Another possibility is an `artists` table, but the comma-separated `artist(s)_name` field would need careful cleanup before that split works well.

## Possible Analysis Questions

- Which artists have the most songs in the dataset?
- Which release years have the most highly streamed songs?
- Do Major or Minor songs have higher average streams?
- Which musical keys have the highest average danceability or energy?
- Are songs with more Spotify playlist appearances also getting more streams?
