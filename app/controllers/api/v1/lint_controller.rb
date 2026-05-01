module Api
  module V1
    class LintController < BaseController
      # POST /api/v1/lint
      # Submit lint results and get AI-powered feedback
      def create
        return unless require_scope!('lint.results:write')

        repository = current_user.repositories.find_by(uuid: params[:repository_uuid])

        return render json: { error: 'Repository not found' }, status: :not_found unless repository

        commit_attempt = repository.commit_attempts.create!(
          commit_attempt_params.merge(user: current_user)
        )

        policy_check = commit_attempt.policy_checks.create!(policy_check_params) if params[:policy_check].present?

        render json: {
          id: commit_attempt.id,
          passed: commit_attempt.passed,
          policy_check_id: policy_check&.id
        }, status: :created
      end

    private

      def commit_attempt_params
        params.expect(
          commit_attempt: %i[message sha branch_name description passed
                             has_lint has_prettier has_eslint has_rubocop]
        )
      end

      def policy_check_params
        params.expect(
          policy_check: %i[passed error_count warning_count
                           fixable_error_count fixable_warning_count
                           report]
        )
      end
    end
  end
end
