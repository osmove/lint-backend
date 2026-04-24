module Admin
  class TeamsController < Admin::BaseController
    before_action :set_team, only: %i[show edit update destroy]

    # GET /teams
    # GET /teams.json
    def index
      @teams = Team.all
    end

    # GET /teams/1
    # GET /teams/1.json
    def show; end

    # GET /teams/new
    def new
      @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

      @team = @user.teams.new

      @form_url = admin_teams_path
    end

    # GET /teams/1/edit
    def edit
      @form_url = admin_team_path(@team)
    end

    # POST /teams
    # POST /teams.json
    def create
      @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

      @team = @user.teams.new(team_params)

      raise ActionController::RoutingError, 'User Not Found' if @user.blank?

      respond_to do |format|
        if @team.save

          format.html { redirect_to admin_team_path(@team), notice: 'Team was successfully created.' }
          format.json { render :show, status: :created, location: admin_team_path(@team) }
        else
          format.html { render :new }
          format.json { render json: @team.errors, status: :unprocessable_content }
        end
      end
    end

    # PATCH/PUT /teams/1
    # PATCH/PUT /teams/1.json
    def update
      respond_to do |format|
        if @team.update(team_params)
          format.html { redirect_to admin_team_path(@team), notice: 'Team was successfully updated.' }
          format.json { render :show, status: :ok, location: admin_team_path(@team) }
        else
          format.html { render :edit }
          format.json { render json: @team.errors, status: :unprocessable_content }
        end
      end
    end

    # DELETE /teams/1
    # DELETE /teams/1.json
    def destroy
      @team.destroy
      respond_to do |format|
        format.html { redirect_to admin_teams_url, notice: 'Team was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.expect(team: [:name, :avatar_url, :team_id, :description, :user_id, { user_ids: [] }])
    end
  end
end
