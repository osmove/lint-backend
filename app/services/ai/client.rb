module Ai
  class Client
    API_URL = 'https://api.anthropic.com/v1/messages'.freeze
    DEFAULT_MODEL = 'claude-sonnet-4-20250514'.freeze

    def initialize(api_key: nil, model: nil)
      @api_key = api_key || ENV.fetch('ANTHROPIC_API_KEY', '')
      @model = model || ENV.fetch('ANTHROPIC_MODEL', DEFAULT_MODEL)
    end

    def chat(system_prompt:, user_message:, max_tokens: 2048)
      response = connection.post do |req|
        req.headers['x-api-key'] = @api_key
        req.headers['anthropic-version'] = '2023-06-01'
        req.headers['Content-Type'] = 'application/json'
        req.body = {
          model: @model,
          max_tokens: max_tokens,
          system: system_prompt,
          messages: [{ role: 'user', content: user_message }]
        }.to_json
      end

      parsed = JSON.parse(response.body)

      if response.success?
        parsed.dig('content', 0, 'text')
      else
        Rails.logger.error("Anthropic API error: #{parsed}")
        nil
      end
    end

  private

    def connection
      @connection ||= Faraday.new(url: API_URL) do |f|
        f.adapter Faraday.default_adapter
        f.options.timeout = 30
        f.options.open_timeout = 10
      end
    end
  end
end
