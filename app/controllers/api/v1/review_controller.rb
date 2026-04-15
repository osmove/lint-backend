module Api
  module V1
    class ReviewController < BaseController
      # POST /api/v1/review
      # Get AI-powered code review for violations
      def create
        violations = params[:violations]

        unless violations.is_a?(Array) && violations.any?
          return render json: { error: "violations array is required" }, status: :unprocessable_entity
        end

        reviewer = Ai::CodeReviewer.new
        results = violations.map do |v|
          suggestion = reviewer.review_violation(
            rule_name: v[:rule_name],
            file_path: v[:file_path],
            line: v[:line],
            message: v[:message],
            source_code: v[:source_code]
          )
          {
            rule_name: v[:rule_name],
            file_path: v[:file_path],
            line: v[:line],
            ai_suggestion: suggestion
          }
        end

        render json: { reviews: results }
      end
    end
  end
end
