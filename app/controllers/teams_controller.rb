class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : nil rescue nil
    if @user.present?
      @teams = Team.where(user_id: @user)
    else
      @teams = Team.all
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

    @team = @user.teams.new

    @form_url = user_teams_path
  end

  # GET /teams/1/edit
  def edit
    @form_url = user_team_path(@team.user, @team)

  end

  # POST /teams
  # POST /teams.json
  def create
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

    @team = @user.teams.new(team_params)
    @team.user = @user


    if !@user.present?
      raise ActionController::RoutingError.new('User Not Found')
    else
      respond_to do |format|
        if @team.save
          format.html { redirect_to user_team_path(@team.user, @team), notice: 'Team was successfully created.' }
          format.json { render :show, status: :created, location: user_team_path(@team.user, @team) }
        else
          format.html { render :new }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
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
      params.require(:team).permit(:name, :avatar_url, :team_id, :description, :user_id)
    end
end
