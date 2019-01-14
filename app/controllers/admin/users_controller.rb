class Admin::UsersController < Admin::BaseController

  before_action :set_user, only: [:show, :edit, :update, :destroy, :user_policies, :user_organizations, :organization_members, :organization_teams]

  def index
    @all_users = User.all.order(created_at: :desc)
    @users = @all_users.where(is_organization: [false, nil]).page(params[:page]).per(15)
  end

  def show
    @repositories = Repository.all.where(user: @user).public.order(name: :asc)
    @top_languages = @user.repositories.group(:platform).order('count_id DESC').count(:id)

    @memberships = @user.memberships

    if @user.is_organization == true
      @teams = Team.where(user_id: @user)
      @members = Membership.where(organization_id: @user)
    else
      @organizations_of_user = []

      if @memberships.count > 0
        @teams_of_user = []
        @memberships.each do |membership|
          if membership.organization_id.present?
            org = User.find(membership.organization_id)
            @organizations_of_user |= [org]
          end
          if membership.team.present?
            @organizations_of_user |= [membership.team.user]
          end
        end
        if @organizations_of_user.count > 0
          @organizations_of_user.each do |org|
            @repositories += org.repositories
          end
        end
      end

    end
    impressionist(@user, @user.slug)
  end

  def organizations_index
    @users = User.all.where(is_organization: true).order(created_at: :desc).page(params[:page]).per(20)
  end

  # GET /admin/users/new
  def new
    @user = User.new
    @form_action = admin_users_path
  end

  # GET /admin/users/1/edit
  def edit
    @form_action = admin_user_path(@user)
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_path(@user), notice: 'Admin user was successfully created.' }
        format.json { render :show, status: :created, location: admin_user_path(@user) }
      else
        @form_action = admin_users_path
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_policies
    @policies = @user.policies
  end

  def user_organizations
    @memberships = @user.memberships

    if @memberships.count > 0
      @organizations_of_user = []
      @memberships.each do |membership|
        if membership.organization_id.present?
          org = User.find(membership.organization_id)
          @organizations_of_user |= [org]
        end
        if membership.team.present?
          @organizations_of_user |= [membership.team.user]
        end
      end
    end
  end

  def organization_members
    @members = []
    @teams = Team.where(user_id: @user)
    @teams.each do |team|
      team.users.each do |team_member|
        @members |= [team_member]

      end
    end
  end

  def organization_teams
    @teams = Team.where(user_id: @user)
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
        end
        format.html { redirect_to admin_user_path(@user), notice: 'Admin user was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_user_path(@user) }
      else
        @form_action = edit_admin_user_path(@user)
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'Admin user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = params[:id] ? User.find_by(slug: params[:id].to_s.downcase) : nil
      if !@user.present?
        raise ActionController::RoutingError.new('User Not Found')
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :login, :slug, :first_name, :last_name, :email, :password, :password_confirmation, :birthday, :phone_country_code, :phone_number, :gender, :address, :address_2, :has_newsletter, :terms_acceptance_date, :locale, :language, :time_zone, :accepted_terms_and_conditions, :role)

    end
end
