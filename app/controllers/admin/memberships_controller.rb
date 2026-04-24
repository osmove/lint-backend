class Admin::MembershipsController < Admin::BaseController
before_action :set_membership, only: [:show, :edit, :update, :destroy]

# GET /memberships
# GET /memberships.json
def index
  @memberships = Membership.all
end

# GET /memberships/1
# GET /memberships/1.json
def show
end

# GET /memberships/new
def new
  @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
  @member = Membership.new
  @form_url =  admin_memberships_path
end

# GET /memberships/1/edit
def edit
  @organization = @membership.user
  @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
  if @organization = @user
    @form_url =  {:controller => "membership", :action => "update"}
  end
end

# POST /memberships
# POST /memberships.json
def create
  @membership = Membership.new(membership_params)

  @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
  if @user.present?
    @membership.user = @user
  end

  @team = Team.find(params[:team_id])

  if @team.present?
    @membership.team = @team
  end


  respond_to do |format|
    if @membership.save

      format.html do
 redirect_to user_team_membership_path(@membership.user, @membership.team, @membership), 
             notice: 'Membership was successfully created.'
      end
      format.json { render :show, status: :created, location: @membership }
    else
      format.html { render :new }
      format.json { render json: @membership.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /memberships/1
# PATCH/PUT /memberships/1.json
def update
  respond_to do |format|
    if @membership.update(membership_params)
      format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
      format.json { render :show, status: :ok, location: @membership }
    else
      format.html { render :edit }
      format.json { render json: @membership.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /memberships/1
# DELETE /memberships/1.json
def destroy
  @membership.destroy
  respond_to do |format|
    format.html { redirect_to memberships_url, notice: 'Membership was successfully destroyed.' }
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
    if @team.present?
      @team = Team.find(team_id)
    else
      # @repository = nil
      raise ActionController::RoutingError.new('Repository Not Found')
    end
    @membership = @team.memberships.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def membership_params
    params.require(:membership).permit(:username, :origin, :origin_url, :avatar_url, :role, :user_id, :team_id)
  end

end
