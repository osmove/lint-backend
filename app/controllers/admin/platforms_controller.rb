class Admin::PlatformsController < Admin::BaseController
  before_action :set_platform, only: [:show, :edit, :update, :destroy]

  # GET /platforms
  # GET /platforms.json
  def index
    @platforms = Platform.all.order(slug: :asc).page(params[:page]).per(10)
  end

  # GET /platforms/1
  # GET /platforms/1.json
  def show
  end

  # GET /platforms/new
  def new
    @platform = Platform.new
    @form_url = admin_platforms_path
  end

  # GET /platforms/1/edit
  def edit
    @form_url = admin_platform_path(@platform)
  end

  # POST /platforms
  # POST /platforms.json
  def create
    @platform = Platform.new(platform_params)

    respond_to do |format|
      if @platform.save
        format.html { redirect_to admin_platforms_path(@platform), notice: 'Platform was successfully created.' }
        format.json { render :show, status: :created, location: admin_platforms_path(@platform) }
      else
        format.html { render :new }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /platforms/1
  # PATCH/PUT /platforms/1.json
  def update
    respond_to do |format|
      if @platform.update(platform_params)
        format.html { redirect_to admin_platforms_path(@platform), notice: 'Platform was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_platforms_path(@platform) }
      else
        format.html { render :edit }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /platforms/1
  # DELETE /platforms/1.json
  def destroy
    @platform.destroy
    respond_to do |format|
      format.html { redirect_to platforms_url, notice: 'Platform was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_platform
      @platform = Platform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def platform_params
      params.require(:platform).permit(:name, :slug, :image, :image_url, :language_id, :framework_id, :visible, 
                                       :is_popular)
    end
end
