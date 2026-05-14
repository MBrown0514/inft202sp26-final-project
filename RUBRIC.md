# INFT221 Final Project Rubric

## Overview

Students choose a multi-table dataset, import it into PostgreSQL, write 8 SQL queries, and submit a working Flask web dashboard. Claude guides them through each step — but the SQL writing is theirs.

**Total: 100 points**

---

## 1. Dataset & Schema (20 pts)

| Criteria | Points |
|----------|--------|
| Dataset has at least 2 related tables linked by a foreign key | 10 |
| `schema.sql` has correct PostgreSQL types, primary keys, and at least one foreign key constraint | 5 |
| Data successfully imported — tables have expected row counts | 5 |

---

## 2. Guided SQL Queries (40 pts — 6 queries × ~7 pts each, rounded)

Each query is saved as `queries/query_N.sql`. Claude guides the student but they write the SQL.

| Query | Concept | Points |
|-------|---------|--------|
| Query 1 | `SELECT` + `WHERE` + `ORDER BY` + `LIMIT` — filter and sort | 6 |
| Query 2 | `COUNT(*)` + `GROUP BY` — count by category | 7 |
| Query 3 | `AVG`/`SUM`/`MIN`/`MAX` + `GROUP BY` — aggregate by category | 7 |
| Query 4 | `GROUP BY` + `HAVING` — filter aggregated groups | 7 |
| Query 5 | `JOIN` — combine both tables | 6 |
| Query 6 | `JOIN` + `GROUP BY` + aggregate — the full combo | 7 |

Grading each query: Full credit if the query runs, returns meaningful results, and uses the specified concept. Half credit if syntactically correct but doesn't answer the intended question. Zero if it doesn't run.

---

## 3. Discussion Queries (20 pts — 2 queries × 10 pts each)

Saved in `discussion/discussion_1.sql` and `discussion/discussion_2.sql`.

| Criteria | Points |
|----------|--------|
| Query runs and returns useful results | 5 |
| Student's written explanation (2-3 sentences) reflects what the data actually shows | 5 |

---

## 4. Web Dashboard (20 pts)

| Criteria | Points |
|----------|--------|
| App runs with `python app.py` and connects to PostgreSQL | 5 |
| Dashboard page shows at least 2 summary stats and 1 Chart.js chart | 5 |
| Browse page shows paginated data | 5 |
| Insights page shows discussion query results with student's explanations | 5 |

---

## 5. Submission (bonus: up to 5 pts)

| Criteria | Points |
|----------|--------|
| GitHub repo with complete commit history | 3 |
| `README.md` describes the dataset, tables, and queries | 2 |

---

## What Claude handles vs. what the student handles

| Claude handles | Student handles |
|---------------|-----------------|
| Schema generation | Running the schema in Beekeeper Studio |
| Import commands | Running the import, troubleshooting row count issues |
| Hints and explanations | Writing every `.sql` file |
| Entire Flask web app | Configuring `.env`, running the server, testing it |
| README template | Filling in their dataset description and query explanations |

The SQL files in `queries/` and `discussion/` are the primary academic deliverable. Claude guides but doesn't write them.
