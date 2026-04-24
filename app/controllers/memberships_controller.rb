class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[show edit update destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    @team = Team.find(params[:team_id])
    @memberships = @team.memberships.includes(:user, :organization, :team)
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show; end

  # GET /memberships/new
  def new
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    @team = Team.find(params[:team_id])
    @member = Membership.new
    @form_url = user_team_memberships_path(@user, @team)
  end

  # GET /memberships/1/edit
  def edit
    @organization = @membership.user
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    @team = @membership.team
    @member = @membership
    return unless (@organization = @user)

    @form_url = user_team_membership_path(@user, @team, @membership)
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)

    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    @membership.user = @user if @user.present?

    @team = Team.find(params[:team_id])

    @membership.team = @team if @team.present?

    respond_to do |format|
      if @membership.save

        format.html do
          redirect_to user_team_membership_path(@membership.user, @membership.team, @membership),
                      notice: 'Membership was successfully created.'
        end
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html do
          redirect_to user_team_membership_path(@membership.user, @membership.team, @membership),
                      notice: 'Membership was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    team = @membership.team
    user = team.user
    @membership.destroy
    respond_to do |format|
      format.html do
        redirect_to user_team_memberships_url(user, team), notice: 'Membership was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    team_id = params[:team_id]
    team_id = params[:id] if params[:team_id].blank?
    @team = Team.find(team_id)
    raise ActionController::RoutingError, 'Repository Not Found' if @team.blank?

    @team = Team.find(team_id)

    # @repository = nil

    @membership = @team.memberships.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def membership_params
    params.expect(membership: %i[username origin origin_url avatar_url role user_id team_id])
  end
end
