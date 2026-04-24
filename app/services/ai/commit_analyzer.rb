module Ai
  class CommitAnalyzer
    SYSTEM_PROMPT = <<~PROMPT
      You are a commit message quality analyzer for Lint.
      Evaluate commit messages against best practices:
      - Uses imperative mood ("Add feature" not "Added feature")
      - First line under 72 characters
      - Describes the "why" not just the "what"
      - Follows Conventional Commits format (optional bonus)
      Return a JSON object with: score (1-10), feedback (string, max 100 words).
    PROMPT

    def initialize(client: nil)
      @client = client || Ai::Client.new
    end

    def analyze(commit_message)
      return { score: 0, feedback: "Empty commit message" } if commit_message.blank?

      response = @client.chat(
        system_prompt: SYSTEM_PROMPT,
        user_message: "Commit message:\n#{commit_message}",
        max_tokens: 256
      )

      parse_analysis(response)
    end

  private

    def parse_analysis(response)
      result = JSON.parse(response)
      {
        score: result["score"].to_i.clamp(1, 10),
        feedback: result["feedback"].to_s.truncate(500)
      }
    rescue JSON::ParserError, TypeError
      { score: 5, feedback: "Unable to analyze commit message" }
    end
  end
end
