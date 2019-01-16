class CommitAttemptsController < ProtectedController
  before_action :set_commit_attempt, only: [:show, :edit, :update, :destroy]


  # before_action :authenticate_user!

  # GET /commit_attempts
  # GET /commit_attempts.json
  def index
    repository_slug = params[:repository_id] || params[:id]
    user_slug = params[:user_id]

    if repository_slug.present? && user_slug.present?
      @repository = Repository.where(uuid: "#{user_slug}/#{repository_slug}").first rescue nil
    else
      raise ActionController::RoutingError.new('Repository Not Found')
    end

    if @repository.present?
      @languages = Language.all
      @commit_attempts = @repository.commit_attempts.includes(:policy_checks)
      @commit_attempts_count = @repository.commit_attempts.order(created_at: :desc).count

      @authors = @commit_attempts.map(&:user).compact.uniq
      @branches = @commit_attempts.map(&:branch_name).compact.uniq


      if params[:author].present?
        @author = params[:author]
        @commit_attempts = @commit_attempts.where(user_id: @author).includes(:policy_checks)
      end

      if params[:branch].present?
        @branch = params[:branch].gsub(/[^a-zA-Z0-9\-]/,"")
        @commit_attempts = @commit_attempts.where(branch_name: @branch).includes(:policy_checks)
        # @commit_attempts = @commit_attempts.where("lower(name) = ?", name.downcase).includes(:policy_checks).order(created_at: :desc).page(params[:page]).per(10)
      end

      if params[:status].present?
        # @status = params[:status]
        if params[:status] == "passed"
          @commit_attempts = @commit_attempts.where(passed: true)
        elsif params[:status] == "failed"
          @commit_attempts = @commit_attempts.where(passed: false)
        end
      end
    else
      @commit_attempts = CommitAttempt.all.includes(:policy_checks)
      @commit_attempts_count = @commit_attempts.count
    end

    @commit_attempts = @commit_attempts.order(created_at: :desc).page(params[:page]).per(10)
    fresh_when etag: @commit_attempts

  end

  # GET /commit_attempts/1
  # GET /commit_attempts/1.json
  def show
    @javascript_logo_url = '/images/platformicons/svg/javascript.svg'
    @ruby_logo_url = '/images/platformicons/svg/ruby.svg'
    @generic_logo_url = '/images/platformicons/svg/generic.svg'

    if @commit_attempt.policy_checks.first.present?
      @policy_check = @commit_attempt.policy_checks.first
      # @report = @policy_check.report["rule_checks_attributes"].sort_by{|h| [h["security_level"], h['line']]}.group_by{ |h| [h['file_path']] }
      # @report = @policy_check.report["rule_checks_attributes"].sort_by! { |h| [h['security_level'] ? h['line'] ? h['security_level'] + -h['line'] : -h['security_level'] : 0] }.group_by{ |h| [h['file_path']] }
          # [h['security_level'] ? 0 : 1, h['security_level']],
          # [h['line'] ? 0 : 1, h['line']],
          # h['line'] ? h['line'] : 0
        # }
      @report = @policy_check.report["rule_checks_attributes"].sort_by!{|h| [h["security_level"] ? h["security_level"] : 0]}.group_by{ |h| [h['file_path']] }

      # @report_sorted = @report_grouped
    else
      @policy_check = nil
    end
  end

  # GET /commit_attempts/new
  def new

    if params[:user_id].present?
      @user = User.find_by(slug: params[:user_id].to_s.downcase)
      @repository = @user.repositories.friendly.find(params[:repository_id])
      if @repository.present?
          @commit_attempt = @repository.commit_attempts.new
      else
        @repository = nil
        raise ActionController::RoutingError.new('Repository Not Found')
      end

    else
      @commit_attempt = CommitAttempt.new
    end
    # @commit_attempt = CommitAttempt.new

  end

  # GET /commit_attempts/1/edit
  def edit
  end

  # POST /commit_attempts
  # POST /commit_attempts.json
  def create

    if params[:user_id].present?
      @user = User.find_by(slug: params[:user_id].to_s.downcase)
      @repository = @user.repositories.friendly.find(params[:repository_id].downcase)
      if @repository.present?
        @commit_attempt = @repository.commit_attempts.new(commit_attempt_params)
        @commit_attempt.user = current_user
      else
        @repository = nil
        raise ActionController::RoutingError.new('Repository Not Found')
      end
    else
      @commit_attempt = CommitAttempt.new(commit_attempt_params)
    end

    respond_to do |format|
      if @commit_attempt.save!
        # @commit_attempt.joins( repository: { policy: { policy_rules: [:rule, { policy_rule_options: [:rule_option, :rule_option_options ] }] } })
        if @commit_attempt.present? && @commit_attempt.repository.present? && @commit_attempt.repository.policy.present?
          # @policy = @commit_attempt.repository.policy
          @policy = Policy.includes( policy_rules: [:linter, { policy_rule_options: [:rule_option, :rule_option_options ] }]).find(@commit_attempt.repository.policy.id)
        end
        format.html { redirect_to @commit_attempt, notice: 'Commit attempt was successfully created.' }
        format.json { render :show, status: :created, location: @commit_attempt }
      else
        format.html { render :new }
        format.json { render json: @commit_attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commit_attempts/1
  # PATCH/PUT /commit_attempts/1.json
  def update
    respond_to do |format|
      if @commit_attempt.update(commit_attempt_params)
        format.html { redirect_to @commit_attempt, notice: 'Commit attempt was successfully updated.' }
        format.json { render :show, status: :ok, location: @commit_attempt }
      else
        format.html { render :edit }
        format.json { render json: @commit_attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commit_attempts/1
  # DELETE /commit_attempts/1.json
  def destroy
    @commit_attempt.destroy
    respond_to do |format|
      format.html { redirect_to commit_attempts_url, notice: 'Commit attempt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commit_attempt
      @commit_attempt = CommitAttempt.find(params[:id])
      # @commit_attempt = CommitAttempt.find(params[:id]).includes(repository: { policy: { policy_rules: [:rule, { policy_rule_options: [:rule_option, :rule_option_options ] }] } })
      # @commit_attempt = CommitAttempt.find(params[:id]).includes(repository: { policy: { policy_rules: [:rule, {policy_rule_options: [:rule_option, :rule_option_options]} ]}})
      # @commit_attempt = CommitAttempt.find(params[:id]).joins(repository: { policy: { policy_rules: [:rule, :policy_rule_options: ]{ rule: {policy_rule_options: { rule_options: :policy_rule_option_options }}}}})


      # @commit_attempt = CommitAttempt.find(params[:id]).includes(repository: { policy: { policy_rules: { policy_rule_options: { rule_options: :guest, policy_rule_option_options }}} })
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commit_attempt_params
      params.require(:commit_attempt).permit(:message, :sha, :branch_name, :description, :commit_id, :user_id, :contributor_id, :push_id, :device_id, :repository_id)
    end
end
