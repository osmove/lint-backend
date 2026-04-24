# class IssuesController < ProtectedController
class IssuesController < ApplicationController
  before_action :set_issue, only: %i[show edit update destroy]

  before_action :authenticate_user!, except: %i[index show]

  # GET /issues
  # GET /issues.json
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

    @issues = @repository.issues.all
    @open_issues = @repository.issues.where(status: 'open')
    @closed_issues = @repository.issues.where(status: 'closed')
  end

  # GET /issues/1
  # GET /issues/1.json
  def show; end

  # GET /issues/new
  def new
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

    @issue = Issue.new
    @form_action = user_repository_issues_path(@user, @repository)
  end

  # GET /issues/1/edit
  def edit
    @form_action = user_repository_issue_path(@user, @repository, @issue)
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

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

    @issue.status = 'open'
    @issue.user = current_user
    @issue.repository = @repository

    respond_to do |format|
      if @issue.save
        format.html do
          redirect_to user_repository_issue_path(@repository.user, @repository, @issue),
                      notice: 'Issue was successfully created.'
        end
        format.json do
          render :show, status: :created, location: user_repository_issue_path(@repository.user, @repository, @issue)
        end
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html do
          redirect_to user_repository_issue_path(@repository.user, @repository, @issue),
                      notice: 'Issue was successfully updated.'
        end
        format.json do
          render :show, status: :ok, location: user_repository_issue_path(@repository.user, @repository, @issue)
        end
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html do
        redirect_to user_repository_issues_path(@repository.user, @repository),
                    notice: 'Issue was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_issue
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

    @issue = Issue.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    params.expect(issue: %i[title slug origin body status repository_id user_id language_id
                            framework_id])
  end
end
