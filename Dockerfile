FROM ruby:3.3-slim AS base

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    curl \
    git \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

COPY . .

RUN bundle exec rails assets:precompile RAILS_ENV=production SECRET_KEY_BASE=placeholder || true

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
