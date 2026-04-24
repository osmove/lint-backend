class Admin::LintersController < Admin::BaseController
  before_action :set_linter, only: [:show, :edit, :update, :destroy]

  # GET /linters
  # GET /linters.json
  def index
    @linters = Linter.all.order(name: :asc).page(params[:page]).per(10)
  end

  # GET /linters/1
  # GET /linters/1.json
  def show
  end

  # GET /linters/new
  def new
    @linter = Linter.new
    @form_url = admin_linters_path
  end

  # GET /linters/1/edit
  def edit
    @form_url = admin_linter_path(@linter)
  end

  # POST /linters
  # POST /linters.json
  def create
    @linter = Linter.new(linter_params)

    respond_to do |format|
      if @linter.save
        format.html { redirect_to admin_linter_path(@linter), notice: 'Linter was successfully created.' }
        format.json { render :show, status: :created, location: admin_linter_path(@linter) }
      else
        format.html { render :new }
        format.json { render json: @linter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /linters/1
  # PATCH/PUT /linters/1.json
  def update
    respond_to do |format|
      if @linter.update(linter_params)
        format.html { redirect_to admin_linter_path(@linter), notice: 'Linter was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_linter_path(@linter) }
      else
        format.html { render :edit }
        format.json { render json: @linter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /linters/1
  # DELETE /linters/1.json
  def destroy
    @linter.destroy
    respond_to do |format|
      format.html { redirect_to admin_linters_url, notice: 'Linter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_linter
      @linter = Linter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def linter_params
      params.require(:linter).permit(:name, :command)
    end
end
