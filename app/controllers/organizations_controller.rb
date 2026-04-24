class OrganizationsController < ProtectedController
  # class UsersController < ProtectedController

  before_action :set_user, only: %i[show edit update destroy]

  before_action :authenticate_user!, except: %i[index show push_token]

  # layout 'dashboard'
  def index
    # @users = User.all
    @my_repositories = []
    if params['q'].present? && params['q'] != '' && params['q'] != 'undefined'
      @query = params['q']
      @users = User.where('slug LIKE ?', "%#{@query.downcase}%")
    else
      @users = User.all
    end

    @users_count = @users.count
    # @users = @users.limit(5).order(slug: :asc)
    @users = @users.order(slug: :asc)
  end

  def show
    @repositories = Repository.where(user: @user).public.order(name: :asc)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.username = @user.organization_name.parameterize if @user.username.blank? && @user.organization_name.present?
    if @user.email.blank?
      # @user.email = current_user.email
      @user.email = "#{@user.username}@lint.to"
    end
    if @user.password.blank?
      # @user.email = current_user.email
      @user.password = '9283jp2d89p239idm2p93imp5'
    end

    # Create Membership As Organization
    membership = Membership.create({ user: current_user, role: 'admin' })
    @user.memberships_as_organization.push(membership)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_content }
      end
    end
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = begin
      if params[:user_id]
        User.find_by(slug: params[:user_id].to_s.downcase)
      else
        params[:id] ? User.find_by(slug: params[:id].to_s.downcase) : nil
      end
    rescue StandardError
      nil
    end
    return if @user.present?

    raise ActionController::RoutingError, 'Account Not Found'
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.expect(user: %i[organization_name username login slug first_name last_name email
                           password password_confirmation birthday phone_country_code phone_number gender address address_2 city zip_code state country is_organization has_newsletter terms_acceptance_date locale language time_zone accepted_terms_and_conditions role])
  end
end
