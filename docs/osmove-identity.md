# Osmove Identity integration

Lint uses Osmove Identity as an OmniAuth provider for first-party SSO.

## Naming

Use `Osmove` in button text and `Osmove Identity` in technical docs. Do not add
new `Osmove Hub`, `/api/v1/hub`, `hub_*`, or `OsmoveHubClient` names.

## Runtime config

Production should use:

```text
OSMOVE_OAUTH_SITE=https://www.osmove.com
OSMOVE_OAUTH_CLIENT_ID=osm_lint_3cf93044297413fcbdec56fc
OSMOVE_OAUTH_USERINFO_URL=/api/v1/identity/me
```

`OSMOVE_OAUTH_CLIENT_SECRET` must be configured in Heroku or credentials and
must never be committed.

If `OSMOVE_OAUTH_USERINFO_URL` is unset, the strategy default is
`/api/v1/identity/me`.

## Important files

- `lib/omniauth/strategies/osmove.rb`
- `config/initializers/devise.rb`
- `test/lib/omniauth/strategies/osmove_test.rb`
- Devise sign-in views render the `Sign in with Osmove` button when configured.

## Flow

1. User clicks `Sign in with Osmove`.
2. Lint POSTs `/users/auth/osmove`.
3. OmniAuth redirects to `https://www.osmove.com/oauth/authorize`.
4. Osmove authenticates at `/account/sign_in`.
5. Osmove redirects back to `https://lint.to/users/auth/osmove/callback`.
6. Lint fetches userinfo from `/api/v1/identity/me`.

The callback path must stay registered in Osmove Identity:

```text
https://lint.to/users/auth/osmove/callback
```

## Tests

Use the repo Ruby via mise:

```sh
mise exec -- bin/rails test test/lib/omniauth/strategies/osmove_test.rb
```

Smoke production config:

```sh
heroku run rails runner 'p Devise.omniauth_configs[:osmove].args' --app lint
```

The printed options must include:

```ruby
user_info_url: "/api/v1/identity/me"
```
