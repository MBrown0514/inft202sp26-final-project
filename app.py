import math
import os

import psycopg2
from dotenv import load_dotenv
from flask import Flask, render_template, request
from psycopg2.extras import RealDictCursor


load_dotenv()

app = Flask(__name__)


def get_connection():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME", "final"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", "postgres"),
        host=os.getenv("DB_HOST", "postgres"),
        port=os.getenv("DB_PORT", "5432"),
    )


def fetch_all(query, params=None):
    with get_connection() as conn:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, params or ())
            return cur.fetchall()


def fetch_one(query, params=None):
    rows = fetch_all(query, params)
    return rows[0] if rows else {}


def read_text(path):
    try:
        with open(path, "r", encoding="utf-8") as file:
            return file.read().strip()
    except FileNotFoundError:
        return ""


@app.route("/")
def index():
    stats = {
        "tracks": fetch_one("SELECT COUNT(*) AS value FROM tracks")["value"],
        "artists": fetch_one("SELECT COUNT(DISTINCT artist_name) AS value FROM tracks")["value"],
        "avg_streams": fetch_one(
            "SELECT ROUND(AVG(streams)) AS value FROM tracks WHERE streams IS NOT NULL"
        )["value"],
        "features": fetch_one("SELECT COUNT(*) AS value FROM track_features")["value"],
    }

    artist_counts = fetch_all(
        """
        SELECT artist_name, COUNT(*) AS track_count
        FROM tracks
        GROUP BY artist_name
        ORDER BY COUNT(*) DESC
        LIMIT 10
        """
    )

    avg_streams = fetch_all(
        """
        SELECT artist_name, ROUND(AVG(streams)) AS average_streams
        FROM tracks
        WHERE streams IS NOT NULL
        GROUP BY artist_name
        ORDER BY AVG(streams) DESC
        LIMIT 10
        """
    )

    return render_template(
        "index.html",
        stats=stats,
        artist_counts=artist_counts,
        avg_streams=avg_streams,
    )


@app.route("/browse")
def browse():
    page = max(request.args.get("page", 1, type=int), 1)
    search = request.args.get("q", "").strip()
    per_page = 25
    offset = (page - 1) * per_page

    where = ""
    params = []
    if search:
        where = "WHERE track_name ILIKE %s OR artist_name ILIKE %s"
        params.extend([f"%{search}%", f"%{search}%"])

    total = fetch_one(f"SELECT COUNT(*) AS value FROM tracks {where}", params)["value"]
    rows = fetch_all(
        f"""
        SELECT track_id, track_name, artist_name, release_year, release_month, release_day, streams
        FROM tracks
        {where}
        ORDER BY track_id
        LIMIT %s OFFSET %s
        """,
        params + [per_page, offset],
    )
    pages = max(math.ceil(total / per_page), 1)

    return render_template(
        "browse.html",
        rows=rows,
        search=search,
        page=page,
        pages=pages,
        total=total,
    )


@app.route("/insights")
def insights():
    discussion_1 = fetch_all(read_text("discussion/discussion_1.sql"))
    discussion_2 = fetch_all(read_text("discussion/discussion_2.sql"))
    return render_template(
        "insights.html",
        discussion_1=discussion_1,
        discussion_2=discussion_2,
        explanation_1=read_text("discussion/discussion_1_explanation.txt"),
        explanation_2=read_text("discussion/discussion_2_explanation.txt"),
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
