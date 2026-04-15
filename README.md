# Omnilint

**The omniscient, authoritative code linter.**

Omnilint is a cloud-based code quality platform that aggregates and orchestrates multiple linters (ESLint, RuboCop, Brakeman, StyleLint, Pylint, and more) under a unified policy engine. Define policies, enforce rules across repositories, and get actionable feedback on every commit.

## Components

| Component | Description | Location |
|-----------|-------------|----------|
| **Backend** (this repo) | Rails web application & API | [jimdou/omnilint](https://github.com/jimdou/omnilint) |
| **CLI** | `lint` npm package - CLI tool | [omnilint/lint](https://github.com/omnilint/lint) |
| **npm** | Published as `lint` on npm | [npmjs.com/package/lint](https://www.npmjs.com/package/lint) |

## Quick Start

### CLI Installation

```bash
# Install globally
npm i -g lint

# Or as a dev dependency
npm i -D lint
```

### CLI Usage

```bash
lint init                    # Initialize repository
lint install:hooks           # Install git hooks
lint lint:staged             # Lint staged files
lint pre-commit              # Run pre-commit checks
lint prettify <extension>    # Format code with Prettier
lint signup / login / logout # Authentication
lint whoami                  # Check auth status
lint --help                  # All commands
```

### Backend Development

**Prerequisites**: Ruby 3.3+, PostgreSQL, Node.js 22+

```bash
# Clone
git clone https://github.com/jimdou/omnilint.git
cd omnilint

# Install dependencies
bundle install
yarn install

# Setup database
bin/rails db:create db:migrate db:seed

# Start server
bin/rails server    # http://localhost:3000
```

## Architecture

### Backend (Rails)

- **Authentication**: Devise with GitHub OAuth
- **Database**: PostgreSQL with 20+ tables
- **Models**: User, Repository, Policy, Rule, Linter, CommitAttempt, etc.
- **Admin panel**: Full CRUD at `/admin`
- **API**: JSON endpoints for CLI communication
- **Payments**: Stripe integration
- **Email**: Postmark transactional emails
- **Monitoring**: Sentry error tracking

### CLI (npm package `lint`)

- Built with Commander.js, Inquirer, Chalk, Ora
- Git hooks integration (pre-commit, post-commit)
- Multi-linter orchestration
- Prettier formatting
- Cloud sync with Omnilint backend

## Supported Linters

- **JavaScript/TypeScript**: ESLint, Prettier
- **Ruby**: RuboCop, Brakeman, ERBLint
- **CSS**: StyleLint
- **Python**: Pylint
- *More coming soon*

## License

- Backend: ISC
- CLI: Apache-2.0
