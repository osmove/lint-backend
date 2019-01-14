# class UsersController < ProtectedController
class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index, :show, :push_token]

  # impressionist unless: :json_request?
  impressionist except: [:show]


  # layout 'dashboard'
  def index
    # @users = User.all
    @my_repositories = []
    if params['q'].present? && params['q'] != '' && params['q'] != 'undefined'
      @query = params['q']
      @users = User.all.where("slug LIKE ?", "%#{@query.downcase}%")
    else
      @users = User.all
    end

    @users_count = @users.count
    # @users = @users.limit(5).order(slug: :asc)
    @users = @users.order(slug: :asc)

  end

  def show
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    @repositories = Repository.all.where(user: @user).public.order(name: :asc)

    impressionist(@user, @user.slug)
  end

  def update
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : nil rescue nil
      if !@user.present?
        raise ActionController::RoutingError.new('User Not Found')
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :login, :slug, :first_name, :last_name, :email, :password, :password_confirmation, :birthday, :phone_country_code, :phone_number, :gender, :address, :address_2, :city, :zip_code, :state, :country, :is_organization, :has_newsletter, :terms_acceptance_date, :locale, :language, :time_zone, :accepted_terms_and_conditions, :role)
    end

end
