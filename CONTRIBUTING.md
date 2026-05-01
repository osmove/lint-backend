# Contributing

## Setup

This repository is the Rails backend for Lint. The CLI lives in the sibling repository [`osmove/lint`](https://github.com/osmove/lint).

Recommended local prerequisites:

- Ruby `3.4.9`
- Node.js `22`
- PostgreSQL `16`

Set up a local environment:

```bash
cp .env.example .env
npm install
npm run runtime:check
npm run bundler:ensure
npm run setup
```

## Common Commands

```bash
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

`npm run verify` is the main maintainer check. It runs the same three categories enforced by CI:

- RuboCop
- Rails tests
- Brakeman

`npm run lint` follows the repository RuboCop severities and does not fail on cops explicitly configured as warnings.

Use `npm run lint:strict` when you want warnings to fail locally too.

`npm run security` uses `config/brakeman.ignore` as the maintained baseline for known warnings and will fail if new warnings appear or if the ignore file becomes stale.

Use `npm run security:strict` for the full unfiltered Brakeman report.

The maintainer npm scripts check the active Ruby version before invoking Rails or Bundler.

If your shell is still using the wrong Ruby version, run `npm run runtime:check` first.

If your local Ruby installation does not already have the Bundler version pinned in `Gemfile.lock`, run `npm run bundler:ensure`.

## Repository Notes

- `origin` should point to `osmove/lint-backend`
- the published CLI package does not live in this repository
- `package.json` depends on the sibling CLI repo through `file:../lint-cli`
- the Heroku remote still uses the legacy app name and has not been renamed

## Pull Requests

- keep branding aligned with `Lint` / `lint.to`
- avoid reintroducing owner-specific logic in views or admin flows
- prefer small, reviewable changes over broad refactors unless the refactor is the task itself
