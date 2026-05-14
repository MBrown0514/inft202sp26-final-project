# INFT202 — Database Final Project

## Getting Started

**1. Fork this repo** — click "Fork" in the top-right corner of this GitHub page.

**2. Clone your fork**

Open **Git Bash** (Windows) or **Terminal** (Mac) and run:
```bash
git clone https://github.com/YOUR_USERNAME/inft202-final-project.git
cd inft202-final-project
```

**3. Open Claude Code in the project folder**
```bash
claude
```

**4. Start the project guide**
```
/db-final-project
```

Claude will take it from there. It will ask about your dataset, guide you through writing your SQL queries, and generate your web dashboard once your queries are done.

---

## What You're Building

- A PostgreSQL database loaded with a real-world dataset
- 8 SQL queries you write yourself (6 guided + 2 your own)
- A Flask web app with charts and a data browser — Claude generates this for you

See [RUBRIC.md](RUBRIC.md) for how you'll be graded.

---

## Requirements & Installation

### Git
Git is what lets you clone this repo and submit your work.

**Windows:**
1. Download the installer from [git-scm.com/download/win](https://git-scm.com/download/win)
2. Run it — use all the default options
3. When it's done, open **Git Bash** (search for it in the Start menu) — use this instead of Command Prompt for all terminal commands in this project
4. Verify: run `git --version` in Git Bash — it should print a version number

**Mac:**
Open Terminal and run `git --version`. If it's not installed, macOS will prompt you to install it automatically.

### GitHub Account
Create a free account at [github.com](https://github.com) if you don't have one.

### Claude Code
Claude Code is the AI assistant that guides you through this project.

**Windows:**
1. Download the Windows installer from [claude.ai/code](https://claude.ai/code)
2. Run the installer and follow the setup steps
3. When prompted, sign in with your Anthropic account (or create one — it's free)
4. Verify: open a new Git Bash window and run `claude --version`

**Mac:**
1. Download the Mac installer from [claude.ai/code](https://claude.ai/code) and follow the setup steps
2. Verify: open a new Terminal window and run `claude --version`

### Everything else
- PostgreSQL — already installed from class
- Beekeeper Studio — already installed from class
- Python 3 — already installed from class

---

## Submitting

When you're done, push your work to your fork and submit the GitHub link on Canvas.

```bash
git add .
git commit -m "Final project complete"
git push
```

> **Note:** Your `.env` file (database password) is in `.gitignore` — it will NOT be pushed. That's intentional.

---

## Getting Unstuck

If Claude gets confused or you want to restart a phase, just say "let's redo this step" and it will back up. If you run into a PostgreSQL error you can't solve, paste the full error message into Claude and it will help you fix it.
