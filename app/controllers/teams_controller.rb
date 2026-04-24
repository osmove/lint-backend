class TeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destroy]

  # GET /teams
  # GET /teams.json
  def index
    @user = begin
      params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : nil
    rescue StandardError
      nil
    end
    @teams = if @user.present?
               Team.where(user_id: @user)
             else
               Team.all
             end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show; end

  # GET /teams/new
  def new
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

    @team = Team.new(user: @user)

    @form_url = user_teams_path(@user)
  end

  # GET /teams/1/edit
  def edit
    @form_url = user_team_path(@team.user, @team)
  end

  # POST /teams
  # POST /teams.json
  def create
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

    @team = Team.new(team_params.merge(user: @user))

    raise ActionController::RoutingError, 'User Not Found' if @user.blank?

    respond_to do |format|
      if @team.save
        format.html { redirect_to user_team_path(@team.user, @team), notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: user_team_path(@team.user, @team) }
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
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
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
    params.expect(team: %i[name avatar_url team_id description user_id])
  end
end
