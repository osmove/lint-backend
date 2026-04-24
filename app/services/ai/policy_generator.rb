module Ai
  class PolicyGenerator
    SYSTEM_PROMPT = <<~PROMPT
      You are a linting policy generator for Lint.
      Given a natural language description of code quality requirements,
      generate a structured policy configuration.
      Return a JSON object with:
      - name: policy name
      - description: brief description
      - rules: array of { linter, rule_name, severity, options }
      Only include rules that exist in common linters (ESLint, RuboCop, Prettier, StyleLint, Pylint).
    PROMPT

    def initialize(client: nil)
      @client = client || Ai::Client.new
    end

    def generate(description, language: nil)
      user_message = "Description: #{description}"
      user_message += "\nPrimary language: #{language}" if language.present?

      response = @client.chat(
        system_prompt: SYSTEM_PROMPT,
        user_message: user_message,
        max_tokens: 1024
      )

      parse_policy(response)
    end

  private

    def parse_policy(response)
      JSON.parse(response).with_indifferent_access
    rescue JSON::ParserError, TypeError
      { name: "Custom Policy", description: "Generated policy", rules: [] }
    end
  end
end
