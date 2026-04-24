class BuildpacksController < ProtectedController
  before_action :set_buildpack, only: [:show, :edit, :update, :destroy]

    
  # GET /buildpacks
  # GET /buildpacks.json
  def index
    @buildpacks = Buildpack.all
  end

  # GET /buildpacks/1
  # GET /buildpacks/1.json
  def show
  end

  # GET /buildpacks/new
  def new
    @buildpack = Buildpack.new
  end

  # GET /buildpacks/1/edit
  def edit
  end

  # POST /buildpacks
  # POST /buildpacks.json
  def create
    @buildpack = Buildpack.new(buildpack_params)

    respond_to do |format|
      if @buildpack.save
        format.html { redirect_to @buildpack, notice: 'Buildpack was successfully created.' }
        format.json { render :show, status: :created, location: @buildpack }
      else
        format.html { render :new }
        format.json { render json: @buildpack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buildpacks/1
  # PATCH/PUT /buildpacks/1.json
  def update
    respond_to do |format|
      if @buildpack.update(buildpack_params)
        format.html { redirect_to @buildpack, notice: 'Buildpack was successfully updated.' }
        format.json { render :show, status: :ok, location: @buildpack }
      else
        format.html { render :edit }
        format.json { render json: @buildpack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buildpacks/1
  # DELETE /buildpacks/1.json
  def destroy
    @buildpack.destroy
    respond_to do |format|
      format.html { redirect_to buildpacks_url, notice: 'Buildpack was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_buildpack
      @buildpack = Buildpack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buildpack_params
      params.require(:buildpack).permit(:name, :web_address, :git_address, :command_id, :repository_id, :user_id)
    end
end
