class Admin::PolicyChecksController < Admin::BaseController
  before_action :set_policy_check, only: [:show, :edit, :update, :destroy]

  # GET /policy_checks
  # GET /policy_checks.json
  def index
    @policy_checks = PolicyCheck.all
  end

  # GET /policy_checks/1
  # GET /policy_checks/1.json
  def show
  end

  # GET /policy_checks/new
  def new
    @policy_check = PolicyCheck.new
    @form_url = admin_policy_checks_path
  end

  # GET /policy_checks/1/edit
  def edit
    @form_url = admin_policy_check_path(@policy_check)
  end

  # POST /policy_checks
  # POST /policy_checks.json
  def create

    Rails.logger.info 'policy_check_params'
    Rails.logger.info policy_check_params

    @policy_check = PolicyCheck.new(policy_check_params)

    respond_to do |format|
      if @policy_check.save
        format.html do
 redirect_to admin_policy_check_path(@policy_check), notice: 'Policy check was successfully created.'
        end
        format.json { render :show, status: :created, location: admin_policy_check_path(@policy_check) }
      else
        format.html { render :new }
        format.json { render json: @policy_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /policy_checks/1
  # PATCH/PUT /policy_checks/1.json
  def update
    respond_to do |format|
      if @policy_check.update(policy_check_params)
        format.html do
 redirect_to admin_policy_check_path(@policy_check), notice: 'Policy check was successfully updated.'
        end
        format.json { render :show, status: :ok, location: admin_policy_check_path(@policy_check) }
      else
        format.html { render :edit }
        format.json { render json: @policy_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /policy_checks/1
  # DELETE /policy_checks/1.json
  def destroy
    @policy_check.destroy
    respond_to do |format|
      format.html do
 redirect_to admin_policy_check_path(@policy_check), notice: 'Policy check was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy_check
      @policy_check = PolicyCheck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def policy_check_params
      params.require(:policy_check).permit(:name, :passed, :commit_attempt_id, :policy_id, :repository_id, :user_id, :contributor_id, :push_id, :device_id,
        :error_count, :warning_count, :offense_count, :fixable_warning_count, :fixable_error_count, :fixable_offense_count,
        rule_checks_attributes:[:id, :name, :passed, :language_id, :rule_id, :policy_check_id, :repository_id, :user_id, :contributor_id, :push_id, :device_id,
          :file_name, :file_path,
          :severity, :severity_level, :message, :line, :column, :line_end, :column_end, :source], report:[:error_count, :warning_count, :offense_count, :fixable_warning_count, :fixable_error_count, :fixable_offense_count,
          rule_checks_attributes:[:id, :name, :passed, :language_id, :rule_id, :policy_check_id, :repository_id, :user_id, :contributor_id, :push_id, :device_id,
            :file_name, :file_path,
            :severity, :severity_level, :message, :line, :column, :line_end, :column_end, :source]])
    end

end
