# Dreeve on Railway

[Dreeve](https://github.com/dreeveapp/dreeve) (formerly Statistics for Strava, AGPL-3.0): a self-hosted dashboard for your sports and fitness data (.fit/.gpx/.tcx files, optional Strava API) with a read-only MCP server. Deploy it on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/CODE)

## What this template runs
- **dreeve**: `ghcr.io/onepush-dev/dreeve:v5.9.1`, the official `ghcr.io/dreeveapp/dreeve:v5.9.1` image (application unmodified). Upstream runs a web container and a daemon container that share volumes; Railway cannot share a volume, so this wrapper runs `bin/console app:daemon:run` next to FrankenPHP in one service. One volume at `/var/www/storage` holds the SQLite database, activity files, the watch folder and backups. Import mode is `files` (no Strava account needed).

## Variables
| Variable | Value |
|---|---|
| `APP_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` |
| `APP_SECRET` | generated secret (signs the admin session cookie) |
| `ADMIN_PASSWORD` | generated secret; hashed with bcrypt at boot into `ADMIN_PASSWORD_HASH` |

Sign in to `/admin` as `admin` with `ADMIN_PASSWORD`. To use the Strava API instead, add `IMPORT_MODE=stravaApi`, `STRAVA_CLIENT_ID`, `STRAVA_CLIENT_SECRET` and `STRAVA_REFRESH_TOKEN` (a free Strava API app).

Not affiliated with Dreeve.
