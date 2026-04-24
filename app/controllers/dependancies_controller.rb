class DependanciesController < ProtectedController
  before_action :set_dependancy, only: %i[show edit update destroy]

  # GET /dependancies
  # GET /dependancies.json
  def index
    @dependancies = Dependancy.all
  end

  # GET /dependancies/1
  # GET /dependancies/1.json
  def show; end

  # GET /dependancies/new
  def new
    @dependancy = Dependancy.new
  end

  # GET /dependancies/1/edit
  def edit; end

  # POST /dependancies
  # POST /dependancies.json
  def create
    @dependancy = Dependancy.new(dependancy_params)

    respond_to do |format|
      if @dependancy.save
        format.html { redirect_to @dependancy, notice: 'Dependancy was successfully created.' }
        format.json { render :show, status: :created, location: @dependancy }
      else
        format.html { render :new }
        format.json { render json: @dependancy.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /dependancies/1
  # PATCH/PUT /dependancies/1.json
  def update
    respond_to do |format|
      if @dependancy.update(dependancy_params)
        format.html { redirect_to @dependancy, notice: 'Dependancy was successfully updated.' }
        format.json { render :show, status: :ok, location: @dependancy }
      else
        format.html { render :edit }
        format.json { render json: @dependancy.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /dependancies/1
  # DELETE /dependancies/1.json
  def destroy
    @dependancy.destroy
    respond_to do |format|
      format.html { redirect_to dependancies_url, notice: 'Dependancy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_dependancy
    @dependancy = Dependancy.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dependancy_params
    params.require(:dependancy).permit(:name, :slug, :repository_id, :user_id)
  end
end
