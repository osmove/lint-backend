module Admin
  class DecryptionsController < Admin::BaseController
    before_action :set_decryption, only: %i[show edit update destroy]

    # GET /decryptions
    # GET /decryptions.json
    def index
      @decryptions = Decryption.order(created_at: :desc).page(params[:page]).per(15)
    end

    # GET /decryptions/1
    # GET /decryptions/1.json
    def show; end

    # GET /decryptions/new
    def new
      @decryption = Decryption.new
      @form_url = admin_decryptions_path
    end

    # GET /decryptions/1/edit
    def edit
      @form_url = admin_decryption_path(@decryption)
    end

    # POST /decryptions
    # POST /decryptions.json
    def create
      @decryption = Decryption.new(decryption_params)

      respond_to do |format|
        if @decryption.save
          format.html { redirect_to admin_decryption_path(@decryption), notice: 'Decryption was successfully created.' }
          format.json { render :show, status: :created, location: admin_decryption_path(@decryption) }
        else
          format.html { render :new }
          format.json { render json: @decryption.errors, status: :unprocessable_content }
        end
      end
    end

    # PATCH/PUT /decryptions/1
    # PATCH/PUT /decryptions/1.json
    def update
      respond_to do |format|
        if @decryption.update(decryption_params)
          format.html { redirect_to admin_decryption_path(@decryption), notice: 'Decryption was successfully updated.' }
          format.json { render :show, status: :ok, location: admin_decryption_path(@decryption) }
        else
          format.html { render :edit }
          format.json { render json: @decryption.errors, status: :unprocessable_content }
        end
      end
    end

    # DELETE /decryptions/1
    # DELETE /decryptions/1.json
    def destroy
      @decryption.destroy
      respond_to do |format|
        format.html { redirect_to admin_decryptions_url, notice: 'Decryption was successfully destroyed.' }
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
      params.expect(decryption: %i[status cypher_name document_id repository_id user_id])
    end
  end
end
