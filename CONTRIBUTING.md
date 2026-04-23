# Contributing

## Setup

This repository is the Rails backend for Lint. The CLI lives in the sibling repository [`osmove/lint`](https://github.com/osmove/lint).

Recommended local prerequisites:

- Ruby `3.3.6`
- Node.js `22`
- PostgreSQL `16`

Bootstrap a local environment:

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
npm run security
npm run verify
```

`npm run verify` is the main maintainer check. It runs the same three categories enforced by CI:

- RuboCop
- Rails tests
- Brakeman

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
