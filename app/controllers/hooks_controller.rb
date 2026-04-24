class HooksController < ApplicationController
  def post_receive
    if params[:repository_uuid].present?

      @nb_messages = 0
      @repositories = Repository.where(uuid: params[:repository_uuid])
      @nb_repositories = @repositories.length
      if @nb_repositories == 1
        @repository = @repositories.first

        # Send security alert push notification
        @nb_messages = @repository.user.send_push_notification("#{@repository.uuid}",
                                                               "New push received for repository '#{@repository.uuid}' on branch master.")

        return respond_to do |format|
          format.html { "Repository: #{@repository.uuid}. #{@nb_messages} sent." }
          format.json do
            render json: { message: "Repository: #{@repository.uuid}. #{@nb_messages} message(s) sent." }, status: :ok
          end
        end

      else
        return respond_to do |format|
          format.html { "Repository not found. #{@nb_messages} sent." }
          format.json do
            render json: { message: "Repository not found. #{@nb_messages} message(s) sent." },
                   status: :unprocessable_content
          end
        end
      end

    else

      return respond_to do |format|
        format.html { "No repository. #{@nb_messages} sent." }
        format.json do
          render json: { message: "No repository. #{@nb_messages} message(s) sent." }, status: :unprocessable_content
        end
      end

    end

    respond_to do |format|
      format.html { "Error. #{@nb_messages} sent." }
      format.json do
        render json: { message: "Error. #{@nb_messages} message(s) sent." }, status: :unprocessable_content
      end
    end
  end
end
