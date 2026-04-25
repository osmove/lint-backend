# Lint Backend

Rails backend for [lint.to](https://lint.to).

This repository powers the web app and API behind Lint: accounts, repositories, policies, billing, lint ingestion, AI-assisted recommendations, and the admin surface used to manage the platform.

## Repositories

| Component | Role | Location |
|-----------|------|----------|
| `lint-cloud` | Rails backend and web app | [osmove/lint-cloud](https://github.com/osmove/lint-cloud) |
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

- Ruby 3.3.6
- PostgreSQL 16
- Node.js 22+

Clone and boot locally:

```bash
git clone https://github.com/osmove/lint-cloud.git
cd lint-cloud
npm install
npm run runtime:check
npm run bundler:ensure
npm run setup
```

The app runs on `http://localhost:3000`.

## Docker

```bash
docker compose up
docker compose run web npm run db:prepare
```

## Common Commands

```bash
npm run setup
npm run runtime:check
npm run bundler:ensure
npm run server
npm run db:setup
npm run db:prepare
npm run console
npm test
npm run lint
npm run lint:strict
npm run security
npm run security:strict
npm run verify
```

These npm scripts are the preferred maintainer entry points for the backend workflow.

`npm run lint` treats configured RuboCop warnings as non-blocking, so maintainer verification can stay green while the repository gradually burns down its legacy style debt tracked in `.rubocop_todo.yml`.

Use `npm run lint:strict` when you want warnings to fail the run as well.

`npm run security` uses `config/brakeman.ignore` as the versioned baseline for known legacy warnings and fails on new warnings, missing notes, or obsolete ignore entries.

Use `npm run security:strict` when you want the full raw Brakeman report without the baseline.

The maintainer npm scripts now self-check the active Ruby version before invoking Rails or Bundler.

If your shell is still using the wrong Ruby, run `npm run runtime:check` first.

If your local Ruby installation is missing the Bundler version pinned in `Gemfile.lock`, run `npm run bundler:ensure`.

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
