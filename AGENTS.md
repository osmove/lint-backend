# Lint Backend

## Project Overview

Lint is a cloud-based code linting and quality management platform with AI-powered features. This repository contains the **web backend** (Rails application) that powers the platform at lint.to.

The companion CLI tool is published as the npm package [`lint`](https://www.npmjs.com/package/lint) from the [osmove/lint](https://github.com/osmove/lint) repository.

## Architecture

- **Framework**: Ruby on Rails 7.2 (Zeitwerk autoloader)
- **Ruby version**: 3.3.6
- **Database**: PostgreSQL 16
- **Server**: Puma 6 (port 3000)
- **Frontend**: Bootstrap 5 + Hotwire (Turbo + Stimulus) + Sprockets
- **Authentication**: Devise 4.9 with GitHub OAuth (omniauth-github 2.0)
- **Osmove Identity**: see `docs/osmove-identity.md` before touching first-party SSO.
- **Payments**: Stripe 12
- **Email**: Postmark
- **Monitoring**: Sentry (sentry-ruby + sentry-rails)
- **AI**: Anthropic Claude API (app/services/ai/)
- **Deployment**: Docker + DigitalOcean
- **CI/CD**: GitHub Actions

## Key Domain Models

- **User** - Authentication, profiles, organizations
- **Repository** - Git repositories linked to the platform
- **Policy** - Linting policies composed of rules
- **Rule** - Individual linting rules (per linter/language)
- **Linter** - Linting tools (ESLint, RuboCop, Brakeman, etc.)
- **CommitAttempt** - Pre-commit lint results (+ AI commit message scoring)
- **PolicyCheck / RuleCheck** - Lint execution results (+ AI suggestions)
- **Organization / Team / Membership** - Multi-tenant management
- **Document** - Repository file/tree browsing

## Directory Structure

```
app/
  controllers/       # 75+ controllers (admin/, api/v1/, public)
  models/            # 44 ActiveRecord models
  views/             # ERB templates (Bootstrap 5 UI)
  assets/            # SCSS, JS (Sprockets)
  services/ai/       # AI service layer (Claude API)
  mailers/           # Email templates (Postmark)
  helpers/           # View helpers
config/
  routes.rb          # Nested routing + API v1 namespace
  database.yml       # PostgreSQL config (ENV-based)
  application.rb     # Main app config (Zeitwerk, Sentry)
  initializers/      # Devise, Stripe, etc.
db/
  schema.rb          # Database schema (20+ tables)
  migrate/           # 100+ migrations
test/                # MiniTest
.github/workflows/   # CI (tests, RuboCop, Brakeman)
```

## Development Commands

```bash
# Docker (recommended)
docker compose up              # starts web + PostgreSQL
docker compose run web npm run db:prepare

# Local development
npm run runtime:check
npm run bundler:ensure
npm run setup
npm run server                 # http://localhost:3000

# Tests
npm test

# Linting
npm run lint
npm run lint:strict
npm run security
npm run security:strict

# Full maintainer check
npm run verify

# Console
npm run console
```

## API v1 Endpoints

Token auth via `Authorization: Bearer <token>` header or `?user_token=<token>` param.

- `POST /api/v1/lint` - Submit lint results
- `POST /api/v1/review` - AI-powered code review for violations
- `POST /api/v1/repositories/:uuid/recommend` - AI rule recommendations
- `POST /api/v1/policies/generate` - Natural language policy generation

## AI Services (app/services/ai/)

- `Ai::Client` - Anthropic Claude API wrapper
- `Ai::CodeReviewer` - Violation explanations and fix suggestions
- `Ai::RuleRecommender` - Language-aware rule recommendations
- `Ai::PolicyGenerator` - Natural language to structured policies
- `Ai::CommitAnalyzer` - Commit message quality scoring

## Configuration

All secrets are managed via environment variables (see `.env.example`):
- GitHub OAuth, Stripe, Postmark, Sentry, Anthropic API key
- Database credentials
- Devise secret key

## RuboCop Notes

- `.rubocop_todo.yml` tracks the current legacy offense baseline for the backend.
- `npm run lint` respects configured warning severities and does not fail on warning-only runs.
- `npm run lint:strict` fails on warnings too when you want a tighter local pass.
- `config/brakeman.ignore` tracks the current Brakeman baseline with notes.
- `npm run security` uses that baseline and fails on new or obsolete entries.
- `npm run security:strict` shows the full raw Brakeman warning set.

## Related Repositories

- **CLI tool**: [osmove/lint](https://github.com/osmove/lint) - npm package `lint`
- **npm package**: https://www.npmjs.com/package/lint
