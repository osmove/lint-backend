module Api
  module V1
    class PoliciesController < BaseController
      # POST /api/v1/policies/generate
      # Generate a policy from natural language description
      def generate
        description = params[:description]

        return render json: { error: 'description is required' }, status: :unprocessable_content if description.blank?

        generator = Ai::PolicyGenerator.new
        policy_config = generator.generate(description, language: params[:language])

        render json: { policy: policy_config }
      end
    end
  end
end
