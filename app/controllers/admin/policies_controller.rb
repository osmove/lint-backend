class Admin::PoliciesController < Admin::BaseController

  before_action :set_policy, only: [:show, :edit, :update, :destroy]
  # before_action :creation_variables, only: [:new, :create]
  # before_action :edition_variables, only: [:edit, :update]

  # GET /policies
  # GET /policies.json
  def index
    @policies = Policy.all
  end

  # GET /policies/1
  # GET /policies/1.json
  def show
    @linters = Linter.all
  end

  # GET /policies/new
  def new
    @policy = Policy.new
    @policy_rules = @policy.policy_rules.build
    @rules = @policy_rules.build_rule
    @linters = Linter.all
    @present_rules = @policy.rules
    @all_rules = Rule.all
    @form_rules = @all_rules - @present_rules
    @form_url = admin_policies_path
  end

  # GET /policies/1/edit
  def edit
    @form_url = admin_policy_path(@policy)
    @policy_rules = @policy.policy_rules.build
    @rules = @policy_rules.build_rule
    @linters = Linter.all
    @present_rules = @policy.rules
    @form_rules = @present_rules
  end

  # POST /policies
  # POST /policies.json
  def create
    @policy = Policy.new(policy_params)
    @policy.user = current_user
    respond_to do |format|
      if @policy.save
      # @policy_rule_option = @policy.policy_rules.policy_rule_option
      # @policy_rule_option_option = @policy.policy_rules.policy_rule_options.policy_rule_option_option
        format.html { redirect_to admin_policy_path(@policy), notice: 'Policy was successfully created.' }
        format.json { render :show, status: :created, location: admin_policy_path(@policy) }
      else
        @linters = Linter.all
        @present_rules = @policy.rules
        @all_rules = Rule.all
        @form_rules = @all_rules - @present_rules
        @form_url = admin_policies_path
        format.html { render :new }
        format.json { render json: @policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /policies/1
  # PATCH/PUT /policies/1.json
  def update

    respond_to do |format|
      if @policy.update(policy_params)
        #@policy_rule_option = @policy.policy_rules.policy_rule_option
        #@policy_rule_option_option = @policy.policy_rules.policy_rule_options.policy_rule_option_option
        format.html { redirect_to admin_policy_path(@policy), notice: 'Policy was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_policy_path(@policy)}
      else
        @linters = Linter.all
        @form_url = admin_policy_path(@policy)
        format.html { render :edit }
        format.json { render json: @policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /policies/1
  # DELETE /policies/1.json
  def destroy
    @policy.destroy
    respond_to do |format|
      format.html { redirect_to admin_policies_url, notice: 'Policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy
      @policy = Policy.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def policy_params
      params.require(:policy).permit(:name, :description, :autofix, :user_id, :prevent_commits_on_errors,
        policy_rules_attributes: [:id, :options, :autofix, :position, :status, :rule_id,
          policy_rule_options_attributes: [:id, :policy_rule, :rule_option, :rule_option_id, :value, :_destroy, policy_rule_option_options_attributes: [:id, :value, :rule_option_option_id], :rule_option_option_ids=> []]
        ])
    end
end
