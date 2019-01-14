class Admin::RulesController < Admin::BaseController
  before_action :set_rule, only: [:show, :edit, :update, :destroy]

  # GET /rules
  # GET /rules.json
  def index
    @rules = Rule.all
  end

  # GET /rules/1
  # GET /rules/1.json
  def show
  end

  # GET /rules/new
  def new
    @rule = Rule.new

    @form_url = admin_rules_path
  end

  # GET /rules/1/edit
  def edit
    @form_url = admin_rule_path(@rule)
  end

  # POST /rules
  # POST /rules.json
  def create
    @rule = Rule.new(rule_params)

    respond_to do |format|
      if @rule.save
        if @rule.rule_options.present?
          @rule.rule_options.each do |rule_option|
            rule_option.rule_option_options.each do |rule_option|
              PolicyRuleOptionOption.create(rule_option_option_id: rule_option)
            end
          end
        end
        format.html { redirect_to admin_rules_path, notice: 'Rule was successfully created.' }
        format.json { render :show, status: :created, location: admin_rules_path }
      else
        format.html { render :new }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to admin_rules_path, notice: 'Rule was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_rules_path }
      else
        format.html { render :edit }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to admin_rules_url, notice: 'Rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rule_params
      params.require(:rule).permit(:name, :slug, :type, :description, :options, :status, :language_id, :framework_id, :platform_id, :parent_id, :linter_id, :fixable,
        rule_options_attributes: [:id, :name, :slug, :description, :value_type, :value, :units, :condition_value, :_destroy,
        rule_option_options_attributes: [:id, :value, :rule_option, :_destroy, policy_rule_option_options_attributes:[:id, :value, :_destroy]]])
    end
end
