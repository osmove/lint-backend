# Lint Backend

Rails backend for [lint.to](https://lint.to).

This repository powers the web app and API behind Lint: accounts, repositories, policies, billing, lint ingestion, AI-assisted recommendations, and the admin surface used to manage the platform.

## Repositories

| Component | Role | Location |
|-----------|------|----------|
| `lint-backend` | Rails backend and web app | [osmove/lint-backend](https://github.com/osmove/lint-backend) |
| `lint` | Repo-local CLI and quality gate | [osmove/lint](https://github.com/osmove/lint) |

## Stack

- Ruby on Rails 7.2
- PostgreSQL 16
- Puma 6
- Bootstrap 5 + Hotwire + Sprockets
- Devise + GitHub OAuth
- Stripe
- Postmark
- Sentry
- Anthropic Claude API integrations

## Main Areas

- Authentication and user accounts
- Repository onboarding and policy management
- API endpoints consumed by the `lint` CLI
- Commit attempts, policy checks, and rule checks
- AI-powered review, explanation, and rule generation
- Billing, plans, and admin tooling

## Local Development

Prerequisites:

- Ruby 3.3+
- PostgreSQL 16
- Node.js 22+

Clone and boot locally:

```bash
git clone https://github.com/osmove/lint-backend.git
cd lint-backend
bundle install
npm install
bin/rails db:create db:migrate db:seed
bin/rails server
```

The app runs on `http://localhost:3000`.

## Docker

```bash
docker compose up
docker compose run web rails db:schema:load
```

## Common Commands

```bash
npm run server
npm run db:setup
npm test
npm run lint
npm run security
```

These npm scripts are thin wrappers around the Rails/Bundler commands used in day-to-day development.

## API Surface

Current CLI-facing endpoints include:

- `POST /api/v1/lint`
- `POST /api/v1/review`
- `POST /api/v1/repositories/:uuid/recommend`
- `POST /api/v1/policies/generate`

Auth is token-based via `Authorization: Bearer <token>` or `?user_token=<token>`.

## Configuration

Application secrets live in environment variables. The main groups are:

- database credentials
- GitHub OAuth
- Stripe
- Postmark
- Sentry
- Anthropic API credentials

See the Rails config and deployment files in this repository for the current expected variables.

## Notes

- This repository is the backend service, not the published npm package.
- The CLI lives in the sibling repo [`osmove/lint`](https://github.com/osmove/lint).
- The current Heroku remote still uses the legacy app name and has not been renamed as part of the codebase cleanup.
