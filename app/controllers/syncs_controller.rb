class SyncsController < ProtectedController

  impressionist

  before_action :set_sync, only: [:show, :edit, :update, :destroy]

  # GET /syncs
  # GET /syncs.json
  def index
    @syncs = Sync.all
  end

  # GET /syncs/1
  # GET /syncs/1.json
  def show
  end

  # GET /syncs/new
  def new
    @sync = Sync.new
  end

  # GET /syncs/1/edit
  def edit
  end

  # POST /syncs
  # POST /syncs.json
  def create
    @sync = Sync.new(sync_params)

    respond_to do |format|
      if @sync.save
        format.html { redirect_to @sync, notice: 'Sync was successfully created.' }
        format.json { render :show, status: :created, location: @sync }
      else
        format.html { render :new }
        format.json { render json: @sync.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /syncs/1
  # PATCH/PUT /syncs/1.json
  def update
    respond_to do |format|
      if @sync.update(sync_params)
        format.html { redirect_to @sync, notice: 'Sync was successfully updated.' }
        format.json { render :show, status: :ok, location: @sync }
      else
        format.html { render :edit }
        format.json { render json: @sync.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /syncs/1
  # DELETE /syncs/1.json
  def destroy
    @sync.destroy
    respond_to do |format|
      format.html { redirect_to syncs_url, notice: 'Sync was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sync
      @sync = Sync.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sync_params
      params.require(:sync).permit(:repository_id, :user_id)
    end
end
