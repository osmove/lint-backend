class Admin::HostingPlansController < Admin::BaseController
  before_action :set_hosting_plan, only: [:show, :edit, :update, :destroy]

  # GET /hosting_plans
  # GET /hosting_plans.json
  def index
    @hosting_plans = HostingPlan.all.order(price_per_month: :asc)
  end

  # GET /hosting_plans/1
  # GET /hosting_plans/1.json
  def show
  end

  # GET /hosting_plans/new
  def new
    @hosting_plan = HostingPlan.new
    @form_url = admin_hosting_plans_path

  end

  # GET /hosting_plans/1/edit
  def edit
    @form_url = admin_hosting_plan_path(@language)

  end

  # POST /hosting_plans
  # POST /hosting_plans.json
  def create
    @hosting_plan = HostingPlan.new(hosting_plan_params)

    respond_to do |format|
      if @hosting_plan.save
        format.html { redirect_to admin_hosting_plans_path, notice: 'Hosting plan was successfully created.' }
        format.json { render :show, status: :created, location: admin_hosting_plans_path(@hosting_plan) }
      else
        format.html { render :new }
        format.json { render json: @hosting_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hosting_plans/1
  # PATCH/PUT /hosting_plans/1.json
  def update
    respond_to do |format|
      if @hosting_plan.update(hosting_plan_params)
        format.html { redirect_to admin_hosting_plans_path, notice: 'Hosting plan was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_hosting_plans_path(@hosting_plan) }
      else
        format.html { render :edit }
        format.json { render json: @hosting_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hosting_plans/1
  # DELETE /hosting_plans/1.json
  def destroy
    @hosting_plan.destroy
    respond_to do |format|
      format.html { redirect_to admin_hosting_plans_url, notice: 'Hosting plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hosting_plan
      @hosting_plan = HostingPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hosting_plan_params
      params.require(:hosting_plan).permit(:name, :slug, :memory, :vcpus, :storage, :transfer, :price_per_month, :price_per_hour)
    end
end
