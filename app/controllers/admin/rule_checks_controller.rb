class Admin::RuleChecksController < Admin::BaseController
  before_action :set_rule_check, only: [:show, :edit, :update, :destroy]

  # GET /rule_checks
  # GET /rule_checks.json
  def index
    @rule_checks = RuleCheck.all
  end

  # GET /rule_checks/1
  # GET /rule_checks/1.json
  def show
  end

  # GET /rule_checks/new
  def new
    @rule_check = RuleCheck.new
    @form_url = admin_rule_checks_path
  end

  # GET /rule_checks/1/edit
  def edit
    @form_url = admin_rule_check_path(@rule_check)
  end

  # POST /rule_checks
  # POST /rule_checks.json
  def create
    @rule_check = RuleCheck.new(rule_check_params)

    respond_to do |format|
      if @rule_check.save
        format.html { redirect_to admin_rule_checks_path, notice: 'Rule check was successfully created.' }
        format.json { render :show, status: :created, location: admin_rule_checks_path }
      else
        format.html { render :new }
        format.json { render json: @rule_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rule_checks/1
  # PATCH/PUT /rule_checks/1.json
  def update
    respond_to do |format|
      if @rule_check.update(rule_check_params)
        format.html { redirect_to admin_rule_check_path(@rule_check), notice: 'Rule check was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_rule_check_path(@rule_check) }
      else
        format.html { render :edit }
        format.json { render json: @rule_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rule_checks/1
  # DELETE /rule_checks/1.json
  def destroy
    @rule_check.destroy
    respond_to do |format|
      format.html { redirect_to admin_rule_check_path(@rule_check), notice: 'Rule check was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule_check
      @rule_check = RuleCheck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rule_check_params
      params.require(:rule_check).permit(:name, :passed, :commit_attempt_id, :policy_check_id, :file_name, :file_path, :rule_id, :repository_id, :linter_id, :user_id, :contributor_id, :push_id, :device_id,
      :file_name, :file_path,
      :severity, :severity_level, :message, :line, :column, :line_end, :column_end, :source)
    end
end
