# Omnilint Backend

## Project Overview

Omnilint is a cloud-based code linting and quality management platform. This repository contains the **web backend** (Rails application) that powers the platform at omnilint.com.

The companion CLI tool is published as the npm package [`lint`](https://www.npmjs.com/package/lint) from the [omnilint/lint](https://github.com/omnilint/lint) repository.

## Architecture

- **Framework**: Ruby on Rails 5.1.6 (targeting upgrade to Rails 8.x)
- **Ruby version**: 2.5.3 (specified in Gemfile, system has 3.3.6)
- **Database**: PostgreSQL
- **Server**: Puma (port 3000)
- **Frontend**: Bootstrap 4 + jQuery + CoffeeScript (asset pipeline)
- **Authentication**: Devise with GitHub OAuth (omniauth-github)
- **Payments**: Stripe
- **Email**: Postmark
- **Monitoring**: Sentry (sentry-raven gem, deprecated)
- **Deployment**: DigitalOcean (previously Heroku)

## Key Domain Models

- **User** - Authentication, profiles, organizations
- **Repository** - Git repositories linked to the platform
- **Policy** - Linting policies composed of rules
- **Rule** - Individual linting rules (per linter/language)
- **Linter** - Linting tools (ESLint, RuboCop, Brakeman, etc.)
- **CommitAttempt** - Pre-commit lint results
- **PolicyCheck / RuleCheck** - Lint execution results
- **Organization / Team / Membership** - Multi-tenant management
- **Document** - Repository file/tree browsing

## Directory Structure

```
app/
  controllers/     # 75+ controllers (admin/ namespace + public)
  models/          # 44 ActiveRecord models
  views/           # ERB templates (Bootstrap 4 UI)
  assets/          # CoffeeScript, SCSS, images
  mailers/         # Email templates (Postmark)
  helpers/         # View helpers
config/
  routes.rb        # Extensive nested routing
  database.yml     # PostgreSQL config
  application.rb   # Main app config
  initializers/    # Devise, Stripe, etc.
db/
  schema.rb        # Database schema (20+ tables)
  migrate/         # 100+ migrations
test/              # MiniTest (Rails default)
public/            # Static assets, icons
```

## Development Commands

```bash
# Install dependencies
bundle install
yarn install

# Database
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# Run server
bin/rails server          # starts on port 3000

# Run tests
bin/rails test

# Console
bin/rails console

# Asset precompilation
bin/rails assets:precompile
```

## Configuration

- **Routes**: `config/routes.rb` - admin namespace, user-scoped resources, Devise auth
- **Database**: `config/database.yml` - PostgreSQL (omnilint_development/test/production)
- **Linting**: `.eslintrc` (JS), `.rubocop.yml` (Ruby)

## Important Notes

- API keys for Postmark and Sentry are currently hardcoded in `config/application.rb` - these should be moved to environment variables
- The `.omnilint/config` file references `jimdou/omnilint-backend` for the Omnilint CLI tool
- The `_permanent` directory contains backup/reference files
- CoffeeScript files are in `app/assets/javascripts/` (to be migrated to modern JS)

## Related Repositories

- **CLI tool**: [omnilint/lint](https://github.com/omnilint/lint) - npm package `lint`
- **npm package**: https://www.npmjs.com/package/lint
