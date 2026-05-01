require 'json'
require 'net/http'
require 'openssl'

class OsmoveJwtVerifier
  DEFAULT_ISSUER = 'https://accounts.osmove.com'.freeze
  DEFAULT_AUDIENCE = 'lint'.freeze
  JWKS_CACHE_TTL = 5.minutes

  class << self
    def decode(token)
      return nil if token.blank?

      payload, = JWT.decode(
        token,
        signing_key_for(token),
        true,
        algorithm: 'RS256',
        aud: audience,
        verify_aud: true,
        iss: issuer,
        verify_iss: true
      )
      payload
    rescue JWT::DecodeError, KeyError, JSON::ParserError, OpenSSL::PKey::PKeyError
      nil
    end

    def clear_cache!
      @jwks_cache = nil
    end

    def issuer
      ENV['OSMOVE_ISSUER'].presence || DEFAULT_ISSUER
    end

    def audience
      ENV['OSMOVE_AUDIENCE'].presence || DEFAULT_AUDIENCE
    end

  private

    def signing_key_for(token)
      return OpenSSL::PKey::RSA.new(ENV['OSMOVE_JWT_PUBLIC_KEY']) if ENV['OSMOVE_JWT_PUBLIC_KEY'].present?

      header = JWT.decode(token, nil, false).last
      kid = header.fetch('kid')
      jwk = jwks.fetch('keys').find { |key| key['kid'] == kid }
      raise KeyError, "unknown jwks kid #{kid.inspect}" unless jwk

      JWT::JWK.import(jwk).public_key
    end

    def jwks
      cached = @jwks_cache
      return cached[:value] if cached && cached[:expires_at].future?

      value = if ENV['OSMOVE_JWKS_JSON'].present?
                JSON.parse(ENV['OSMOVE_JWKS_JSON'])
              else
                fetch_jwks
              end

      @jwks_cache = { value: value, expires_at: JWKS_CACHE_TTL.from_now }
      value
    end

    def fetch_jwks
      uri = URI(ENV['OSMOVE_JWKS_URL'].presence || "#{issuer}/.well-known/jwks.json")
      response = Net::HTTP.get_response(uri)
      raise JWT::DecodeError, "jwks fetch failed: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    end
  end
end
