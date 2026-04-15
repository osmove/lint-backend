module Api
  module V1
    class RecommendController < BaseController
      # POST /api/v1/repositories/:repository_uuid/recommend
      # Get AI-powered rule recommendations for a repository
      def create
        repository = current_user.repositories.find_by(uuid: params[:repository_uuid])

        unless repository
          return render json: { error: "Repository not found" }, status: :not_found
        end

        recommender = Ai::RuleRecommender.new
        recommendations = recommender.recommend(repository)

        render json: { recommendations: recommendations }
      end
    end
  end
end
