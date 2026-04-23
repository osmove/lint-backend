module Ai
  class CodeReviewer
    SYSTEM_PROMPT = <<~PROMPT
      You are an expert code reviewer for Lint, a code quality platform.
      When given a linting violation with code context, provide:
      1. A clear, concise explanation of why this is a problem
      2. A suggested fix with the corrected code
      Keep responses under 200 words. Be specific and actionable.
    PROMPT

    def initialize(client: nil)
      @client = client || Ai::Client.new
    end

    def review_violation(rule_name:, file_path:, line:, message:, source_code: nil)
      user_message = build_prompt(rule_name, file_path, line, message, source_code)

      @client.chat(
        system_prompt: SYSTEM_PROMPT,
        user_message: user_message,
        max_tokens: 512
      )
    end

    def review_violations(violations)
      violations.map do |v|
        {
          rule: v[:rule_name],
          file: v[:file_path],
          line: v[:line],
          ai_suggestion: review_violation(**v)
        }
      end
    end

    private

    def build_prompt(rule_name, file_path, line, message, source_code)
      prompt = "Rule: #{rule_name}\nFile: #{file_path}:#{line}\nMessage: #{message}"
      prompt += "\n\nCode:\n```\n#{source_code}\n```" if source_code.present?
      prompt
    end
  end
end
