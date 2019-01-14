class DecryptionsController < ProtectedController

  impressionist
    
  before_action :set_decryption, only: [:show, :edit, :update, :destroy]

  # GET /decryptions
  # GET /decryptions.json
  def index
    @decryptions = Decryption.all
  end

  # GET /decryptions/1
  # GET /decryptions/1.json
  def show
  end

  # GET /decryptions/new
  def new
    @decryption = Decryption.new
  end

  # GET /decryptions/1/edit
  def edit
  end

  # POST /decryptions
  # POST /decryptions.json
  def create
    @decryption = Decryption.new(decryption_params)

    respond_to do |format|
      if @decryption.save
        format.html { redirect_to @decryption, notice: 'Decryption was successfully created.' }
        format.json { render :show, status: :created, location: @decryption }
      else
        format.html { render :new }
        format.json { render json: @decryption.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decryptions/1
  # PATCH/PUT /decryptions/1.json
  def update
    respond_to do |format|
      if @decryption.update(decryption_params)
        format.html { redirect_to @decryption, notice: 'Decryption was successfully updated.' }
        format.json { render :show, status: :ok, location: @decryption }
      else
        format.html { render :edit }
        format.json { render json: @decryption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decryptions/1
  # DELETE /decryptions/1.json
  def destroy
    @decryption.destroy
    respond_to do |format|
      format.html { redirect_to decryptions_url, notice: 'Decryption was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_decryption
      @decryption = Decryption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def decryption_params
      params.require(:decryption).permit(:status, :cypher_name, :document_id, :repository_id, :user_id)
    end
end
