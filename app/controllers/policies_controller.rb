class PoliciesController < ApplicationController
  before_action :set_policy, only: [:show, :edit, :update, :destroy]

  # GET /policies
  # GET /policies.json
  def index
    if params[:user_id].present?
      @policies = current_user.policies
    end
  end

  # GET /policies/1
  # GET /policies/1.json
  def show
    @linters = Linter.all
    @policy_rules = @policy.policy_rules.order(name: :asc)
    # @policy_rules_grouped = @policy.policy_rules.order(name: :asc).group_by{|h| h.linter}

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
  end

  # GET /policies/1/edit
  def edit
    @policy_rules = @policy.policy_rules.build
    @rules = @policy_rules.build_rule
    @linters = Linter.all
    @present_rules = @policy.rules
    @form_rules = @present_rules
  end

  def user_policies
    @policies = current_user.policies

  end

  # POST /policies
  # POST /policies.json
  def create
    @policy = current_user.policies.new(policy_params)
    respond_to do |format|
      if @policy.save
        format.html { redirect_to user_policy_path(@policy.user, @policy), notice: 'Policy was successfully created.' }
        format.json { render :show, status: :created, location: user_policy_path(@policy.user, @policy) }
      else
        @linters = Linter.all
        @present_rules = @policy.rules
        @all_rules = Rule.all
        @form_rules = @all_rules - @present_rules
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
        format.html { redirect_to user_policy_path(@policy.user, @policy), notice: 'Policy was successfully updated.' }
        format.json { render :show, status: :ok, location: user_policy_path(@policy.user, @policy) }
      else
        @linters = Linter.all
        format.html { render :edit }
        format.json { render json: @policy.errors, status: :unprocessable_entity }
      end
    end
  end
  #sss
  # DELETE /policies/1
  # DELETE /policies/1.json
  def destroy
    @policy.destroy
    respond_to do |format|
      format.html { redirect_to user_policies_path(current_user), notice: 'Policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy
      # @policy = Policy.find(params[:id])
      # @policy = Policy.includes( policy_rules: [{rule: [:linter, { rule_options: [:rule_option_options ] }]}, { policy_rule_options: [:rule_option, :rule_option_options ] }]).find(params[:id])
      @policy = Policy.includes( policy_rules: [{rule: [{ rule_options: [:rule_option_options ] }]}, { policy_rule_options: [:rule_option, :rule_option_options ] }]).find(params[:id])

    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def policy_params
      params.require(:policy).permit(:name, :description, :autofix, :user_id, :prevent_commits_on_errors,
        policy_rules_attributes: [:id, :options, :autofix, :position, :status, :rule_id, :_destroy,
          policy_rule_options_attributes: [:id, :policy_rule, :rule_option, :rule_option_id, :value, :_destroy, :rule_option_option_ids=> []]
        ])
    end
end
