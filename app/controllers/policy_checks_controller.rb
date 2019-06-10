class PolicyChecksController < ApplicationController
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
  end

  # GET /policy_checks/1/edit
  def edit
  end

  # POST /policy_checks
  # POST /policy_checks.json
  def create
    @policy_check = PolicyCheck.new(policy_check_params)

    respond_to do |format|
      if @policy_check.save!
        format.html { redirect_to @policy_check, notice: 'Policy check was successfully created.' }
        format.json { render :show, status: :created, location: @policy_check }
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
        format.html { redirect_to @policy_check, notice: 'Policy check was successfully updated.' }
        format.json { render :show, status: :ok, location: @policy_check }
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
      format.html { redirect_to policy_checks_url, notice: 'Policy check was successfully destroyed.' }
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
          :severity, :severity_level, :message, :line, :column, :line_end, :column_end, :source], report:[:omnilint_version, :cli_version, :source_shell_command, :node_version, :npm_version, :ruby_version, :python_version, :lint_execution_time, :error_count, :warning_count, :offense_count, :fixable_warning_count, :fixable_error_count, :fixable_offense_count,
          rule_checks_attributes:[:id, :name, :linter, :passed, :language_id, :rule_id, :policy_check_id, :repository_id, :user_id, :contributor_id, :push_id, :device_id,
            :file_name, :file_path,
            :severity, :severity_level, :message, :line, :column, :line_end, :column_end, source:[:line, :code]], :staged_files => [], :javascript_files => [], :ruby_files => [], :formatted_files => [], :inspected_files => [], :not_inspected_files => []])
    end
end
