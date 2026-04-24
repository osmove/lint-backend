module Ai
  class RuleRecommender
    SYSTEM_PROMPT = <<~PROMPT
      You are a linting configuration expert for Lint.
      Given a repository's languages, frameworks, and file structure,
      recommend the most important linting rules to enable.
      Return a JSON array of objects with: linter, rule_name, severity (warn/error), reason.
      Limit to the 10 most impactful rules. Be pragmatic, not exhaustive.
    PROMPT

    def initialize(client: nil)
      @client = client || Ai::Client.new
    end

    def recommend(repository)
      languages = detect_languages(repository)
      existing_rules = repository.policy&.policy_rules&.map { |pr| pr.rule&.name } || []

      user_message = <<~MSG
        Repository: #{repository.name}
        Languages: #{languages.join(', ')}
        Existing rules: #{existing_rules.join(', ')}
        Please recommend additional linting rules.
      MSG

      response = @client.chat(
        system_prompt: SYSTEM_PROMPT,
        user_message: user_message,
        max_tokens: 1024
      )

      parse_recommendations(response)
    end

  private

    def detect_languages(repository)
      languages = []
      languages << repository.platform&.name if repository.platform.present?
      languages << "JavaScript" if languages.empty?
      languages
    end

    def parse_recommendations(response)
      JSON.parse(response)
    rescue JSON::ParserError, TypeError
      []
    end
  end
end
