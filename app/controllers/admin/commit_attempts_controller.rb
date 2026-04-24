module Admin
  class CommitAttemptsController < Admin::BaseController
    before_action :set_commit_attempt, only: %i[show edit update destroy]

    # GET /commit_attempts
    # GET /commit_attempts.json
    def index
      @commit_attempts = CommitAttempt.order(created_at: :desc).page(params[:page]).per(15)
    end

    # GET /commit_attempts/1
    # GET /commit_attempts/1.json
    def show; end

    # GET /commit_attempts/new
    def new
      @commit_attempt = CommitAttempt.new
      @form_url = admin_commit_attempts_path
    end

    # GET /commit_attempts/1/edit
    def edit
      @form_url = admin_commit_attempt_path(@commit_attempt)
    end

    # POST /commit_attempts
    # POST /commit_attempts.json
    def create
      @commit_attempt = CommitAttempt.new(commit_attempt_params)

      respond_to do |format|
        if @commit_attempt.save
          format.html do
            redirect_to admin_commit_attempt_path(@commit_attempt), notice: 'Commit attempt was successfully created.'
          end
          format.json { render :show, status: :created, location: admin_commit_attempt_path(@commit_attempt) }
        else
          format.html { render :new }
          format.json { render json: @commit_attempt.errors, status: :unprocessable_content }
        end
      end
    end

    # PATCH/PUT /commit_attempts/1
    # PATCH/PUT /commit_attempts/1.json
    def update
      respond_to do |format|
        if @commit_attempt.update(commit_attempt_params)
          format.html do
            redirect_to admin_commit_attempt_path(@commit_attempt), notice: 'Commit attempt was successfully updated.'
          end
          format.json { render :show, status: :ok, location: admin_commit_attempt_path(@commit_attempt) }
        else
          format.html { render :edit }
          format.json { render json: @commit_attempt.errors, status: :unprocessable_content }
        end
      end
    end

    # DELETE /commit_attempts/1
    # DELETE /commit_attempts/1.json
    def destroy
      @commit_attempt.destroy
      respond_to do |format|
        format.html do
          redirect_to admin_commit_attempt_path(@commit_attempt), notice: 'Commit attempt was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_commit_attempt
      @commit_attempt = CommitAttempt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commit_attempt_params
      params.expect(commit_attempt: %i[message sha branch_name description commit_id user_id
                                       contributor_id push_id device_id repository_id])
    end
  end
end
