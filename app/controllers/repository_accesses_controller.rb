# class RepositoryAccessesController < ApplicationController
class RepositoryAccessesController < ProtectedController
  # before_action :set_repository_access, only: [:show, :edit, :update, :destroy]
  before_action :set_repository_access, only: %i[show edit destroy]

  before_action :authenticate_user!

  # GET /repository_accesses

  # GET /repository_accesses.json
  def index
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : nil
    if @user.present?
      @repository = if @user == current_user
                      @user.repositories.friendly.find(params[:repository_id])
                    else
                      @user.repositories.public.friendly.find(params[:repository_id])
                    end
    else
      @repository = nil
      raise ActionController::RoutingError, 'Repository Not Found'
    end

    # @repository_accesses = RepositoryAccess.all

    @repository_accesses = @repository.repository_accesses.all
    # @open_issues = @repository.issues.where(status: 'open')
    # @closed_issues = @repository.issues.where(status: 'closed')
  end

  # GET /repository_accesses/1
  # GET /repository_accesses/1.json
  def show
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    if @user.present?
      @repository = if @user == current_user
                      @user.repositories.friendly.find(params[:repository_id])
                    else
                      @user.repositories.public.friendly.find(params[:repository_id])
                    end
    else
      @repository = nil
      raise ActionController::RoutingError, 'Repository Not Found'
    end
  end

  # GET /repository_accesses/new
  def new
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    if @user.present?
      @repository = if @user == current_user
                      @user.repositories.friendly.find(params[:repository_id])
                    else
                      @user.repositories.public.friendly.find(params[:repository_id])
                    end
    else
      @repository = nil
      raise ActionController::RoutingError, 'Repository Not Found'
    end

    @repository_access = @repository.repository_accesses.new
    # @repository_access = RepositoryAccess.new
    @form_action = user_repository_repository_accesses_path(@user, @repository)
  end

  # GET /repository_accesses/1/edit
  def edit
    @form_action = user_repository_repository_access_path(@repository_access.user, @repository_access.repository,
                                                          @repository_access)
  end

  # POST /repository_accesses
  # POST /repository_accesses.json
  def create
    @repository_access = RepositoryAccess.new(repository_access_params)

    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : nil
    if @user.present?
      @repository = if @user == current_user
                      @user.repositories.friendly.find(params[:repository_id])
                    else
                      @user.repositories.public.friendly.find(params[:repository_id])
                    end
    else
      @repository = nil
      raise ActionController::RoutingError, 'Repository Not Found'
    end

    @repository_access.status = 'active'
    # @repository_access.user = current_user
    @repository_access.repository = @repository

    @form_action = user_repository_repository_accesses_path(@user, @repository)

    respond_to do |format|
      if @repository_access.save
        format.html do
          redirect_to user_repository_repository_access_path(@repository.user, @repository, @repository_access),
                      notice: 'Repository access was successfully created.'
        end
        format.json do
          render :show, status: :created,
                        location: user_repository_repository_access_path(@repository.user, @repository, @repository_access)
        end
      else
        format.html { render :new }
        format.json { render json: @repository_access.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /repository_accesses/1
  # PATCH/PUT /repository_accesses/1.json
  def update
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : nil
    if @user.present?
      @repository = if @user == current_user
                      @user.repositories.friendly.find(params[:repository_id])
                    else
                      Repository.all.friendly.find(params[:repository_id])
                    end
    else
      @repository = nil
      raise ActionController::RoutingError, 'Repository Not Found'
    end

    @repository_access = @repository.repository_accesses.find(params[:id])

    respond_to do |format|
      if @repository_access.update(repository_access_params)
        format.html do
          redirect_to user_repository_repository_access_path(@repository.user, @repository, @repository_access),
                      notice: 'Repository access was successfully updated.'
        end
        format.json do
          render :show, status: :ok,
                        location: user_repository_repository_access_path(@repository.user, @repository, @repository_access)
        end
      else
        format.html { render :edit }
        format.json { render json: @repository_access.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /repository_accesses/1
  # DELETE /repository_accesses/1.json
  def destroy
    @repository_access.destroy
    respond_to do |format|
      format.html do
        redirect_to user_repository_repository_accesses_path(@repository.user, @repository),
                    notice: 'Repository access was successfully revoked.'
      end
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_repository_access
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    if @user.present?
      @repository = if @user == current_user
                      @user.repositories.friendly.find(params[:repository_id])
                    else
                      @user.repositories.public.friendly.find(params[:repository_id])
                    end
    else
      @repository = nil
      raise ActionController::RoutingError, 'Repository Not Found'
    end

    @repository_access = @repository.repository_accesses.find(params[:id])
    # @repository_access = RepositoryAccess.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def repository_access_params
    params.expect(repository_access: %i[role status user_id repository_id
                                        enable_admin_email_notifications enable_email_notifications enable_admin_push_notifications enable_push_notifications])
  end
end
