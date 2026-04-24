class Admin::FrameworksController < Admin::BaseController
  before_action :set_framework, only: %i[show edit update destroy]

  # GET /frameworks
  # GET /frameworks.json
  def index
    @frameworks = Framework.all.order(slug: :asc).page(params[:page]).per(10)
  end

  # GET /frameworks/1
  # GET /frameworks/1.json
  def show; end

  # GET /frameworks/new
  def new
    @framework = Framework.new
    @form_url = admin_frameworks_path
  end

  # GET /frameworks/1/edit
  def edit
    @form_url = admin_framework_path(@framework)
  end

  # POST /frameworks
  # POST /frameworks.json
  def create
    @framework = Framework.new(framework_params)

    respond_to do |format|
      if @framework.save
        format.html { redirect_to admin_frameworks_path, notice: 'Framework was successfully created.' }
        format.json { render :show, status: :created, location: admin_frameworks_path }
      else
        format.html { render :new }
        format.json { render json: @framework.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /frameworks/1
  # PATCH/PUT /frameworks/1.json
  def update
    respond_to do |format|
      if @framework.update(framework_params)
        format.html { redirect_to admin_frameworks_path, notice: 'Framework was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_frameworks_path }
      else
        format.html { render :edit }
        format.json { render json: @framework.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /frameworks/1
  # DELETE /frameworks/1.json
  def destroy
    @framework.destroy
    respond_to do |format|
      format.html { redirect_to admin_frameworks_url, notice: 'Framework was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_framework
    @framework = Framework.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def framework_params
    params.require(:framework).permit(:name, :slug, :image, :image_url, :visible)
  end
end
