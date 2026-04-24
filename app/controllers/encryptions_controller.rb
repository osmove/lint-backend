class EncryptionsController < ProtectedController
  before_action :set_encryption, only: %i[show edit update destroy]

  # GET /encryptions
  # GET /encryptions.json
  def index
    @encryptions = Encryption.all
  end

  # GET /encryptions/1
  # GET /encryptions/1.json
  def show; end

  # GET /encryptions/new
  def new
    @encryption = Encryption.new
  end

  # GET /encryptions/1/edit
  def edit; end

  # POST /encryptions
  # POST /encryptions.json
  def create
    @encryption = Encryption.new(encryption_params)

    respond_to do |format|
      if @encryption.save
        format.html { redirect_to @encryption, notice: 'Encryption was successfully created.' }
        format.json { render :show, status: :created, location: @encryption }
      else
        format.html { render :new }
        format.json { render json: @encryption.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /encryptions/1
  # PATCH/PUT /encryptions/1.json
  def update
    respond_to do |format|
      if @encryption.update(encryption_params)
        format.html { redirect_to @encryption, notice: 'Encryption was successfully updated.' }
        format.json { render :show, status: :ok, location: @encryption }
      else
        format.html { render :edit }
        format.json { render json: @encryption.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /encryptions/1
  # DELETE /encryptions/1.json
  def destroy
    @encryption.destroy
    respond_to do |format|
      format.html { redirect_to encryptions_url, notice: 'Encryption was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_encryption
    @encryption = Encryption.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def encryption_params
    params.expect(encryption: %i[status cypher_name document_id repository_id user_id])
  end
end
