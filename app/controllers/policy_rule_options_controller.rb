class PolicyRuleOptionsController < ApplicationController
  before_action :set_policy_rule_option, only: [:show, :edit, :update, :destroy]

  # GET /policy_rule_options
  # GET /policy_rule_options.json
  def index
    @policy_rule_options = PolicyRuleOption.all
  end

  # GET /policy_rule_options/1
  # GET /policy_rule_options/1.json
  def show
  end

  # GET /policy_rule_options/new
  def new
    @policy_rule_option = PolicyRuleOption.new
  end

  # GET /policy_rule_options/1/edit
  def edit
  end

  # POST /policy_rule_options
  # POST /policy_rule_options.json
  def create
    @policy_rule_option = PolicyRuleOption.new(policy_rule_option_params)
    if params[:value].present?
      @value = params[:value]
      if @value.kind_of(Array)
        @policy_rule_option.value = @value.reject { |c| c.empty? }.join(",")
      end
    end

    respond_to do |format|
      if @policy_rule_option.save
        format.html { redirect_to @policy_rule_option, notice: 'Policy rule option was successfully created.' }
        format.json { render :show, status: :created, location: @policy_rule_option }
      else
        format.html { render :new }
        format.json { render json: @policy_rule_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /policy_rule_options/1
  # PATCH/PUT /policy_rule_options/1.json
  def update
    if params[:value].present?
      @value = params[:value]
      if @value.kind_of(Array)
        @policy_rule_option.value = @value.reject { |c| c.empty? }.join(",")
      end
    end
    respond_to do |format|
      if @policy_rule_option.update(policy_rule_option_params)
        format.html { redirect_to @policy_rule_option, notice: 'Policy rule option was successfully updated.' }
        format.json { render :show, status: :ok, location: @policy_rule_option }
      else
        format.html { render :edit }
        format.json { render json: @policy_rule_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /policy_rule_options/1
  # DELETE /policy_rule_options/1.json
  def destroy
    @policy_rule_option.destroy
    respond_to do |format|
      format.html { redirect_to policy_rule_options_url, notice: 'Policy rule option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy_rule_option
      @policy_rule_option = PolicyRuleOption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def policy_rule_option_params
      params.require(:policy_rule_option).permit(:policy_rule_id, :rule_option_id, :value)
    end
end
