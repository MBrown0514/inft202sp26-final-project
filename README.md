# Spotify Most Streamed Songs Database Project

## Project Overview

This project uses a Spotify most-streamed songs CSV dataset to explore artists, songs, streaming totals, and music features. The data includes track names, artist names, release information, stream counts, playlist/chart appearances, and audio details such as BPM, song key, and mode.

The main focus of this project is artists. I used PostgreSQL to organize the dataset into related tables, wrote SQL queries to analyze artist performance, and built a Flask dashboard to display the results.

## Dataset

- Dataset name: Spotify Most Streamed Songs
- Source file: `Spotify Most Streamed Songs.csv`
- Rows imported: 953

One row in the original CSV represents one Spotify track. Some columns describe the song and artist, while other columns describe streaming numbers, chart activity, and music features.

## Data Exploration

During exploration, I found that the dataset has 953 rows and 25 columns. The song title column is not fully unique, so I used a generated `track_id` as the primary key instead of using `track_name`.

I also noticed that some values were missing in columns like `key`, `in_shazam_charts`, and `cover_url`. One row had a broken value in the `streams` column, so the import process handled that value as blank/null instead of stopping the whole import.

## Database Schema

The database has two related tables:

### `tracks`

This table stores the main song and artist information.

Important columns:

- `track_id`
- `track_name`
- `artist_name`
- `release_year`
- `release_month`
- `release_day`
- `streams`

### `track_features`

This table stores playlist, chart, and music feature details for each track.

Important columns:

- `feature_id`
- `track_id`
- `in_spotify_playlists`
- `in_spotify_charts`
- `in_apple_charts`
- `in_apple_playlists`
- `in_deezer_playlists`
- `in_deezer_charts`
- `bpm`
- `song_key`
- `mode`

The relationship is:

`track_features.track_id` connects to `tracks.track_id`.

## Guided SQL Queries

The six guided queries are saved in the `queries/` folder.

1. `query_1.sql` finds the 10 Taylor Swift tracks with the most streams.
2. `query_2.sql` counts how many tracks each artist has and ranks the artists by track count.
3. `query_3.sql` finds each artist's average streams per track.
4. `query_4.sql` filters the artist averages to artists with more than 1 billion average streams.
5. `query_5.sql` joins both tables to show The Weeknd tracks with streams, BPM, song key, and mode.
6. `query_6.sql` joins both tables, groups by artist, and finds each artist's average BPM and track count.

## Discussion Queries

The discussion queries are saved in the `discussion/` folder.

### Discussion Query 1

Question: Which 10 artists have the most total streams across all their tracks?

Explanation:
The top 10 most streamed artists are The Weeknd, Taylor Swift, Ed Sheeran, Harry Styles, Bad Bunny, Olivia Rodrigo, Eminem, Bruno Mars, Arctic Monkeys, and Imagine Dragons. These artists have billions of streams on most of their songs. The most surprising one to see up there was Arctic Monkeys because I had never seen or heard of them before.

### Discussion Query 2

Question: What are The Weeknd's top 3 most-streamed songs?

Explanation:
The top three songs are "Blinding Lights," "The Hills," and "Die For You." I am personally not surprised about "Blinding Lights," but I am surprised that "Starboy" is not up there. Other than that, I am not surprised about these songs being so high because these are songs that are played a lot and I listen to personally.

## Web App

The project includes a Flask dashboard with three pages:

- Dashboard: summary numbers and charts
- Browse: searchable track table
- Insights: the two discussion questions with query results and explanations

The app runs with Docker and connects to the PostgreSQL database.

## How To Run The Project

Start Docker Desktop first.

Then, from this project folder, run:

```bash
docker compose --profile app up --build
```

Open the dashboard at:

```text
http://localhost:5001
```

The app uses port `5001` because port `5000` was already being used on this computer.

To stop the app, run:

```bash
docker compose --profile app stop
```

## Database Connection

PostgreSQL connection:

- Host: `localhost`
- Port: `5432`
- User: `postgres`
- Password: `postgres`
- Database: `final`

Adminer is available at:

```text
http://localhost:8080
```

## Files Created

- `data_exploration.md`
- `schema_plan.md`
- `table_creation.sql`
- `import.sql`
- `queries/query_1.sql` through `queries/query_6.sql`
- `discussion/discussion_1.sql`
- `discussion/discussion_2.sql`
- `app.py`
- `templates/base.html`
- `templates/index.html`
- `templates/browse.html`
- `templates/insights.html`
