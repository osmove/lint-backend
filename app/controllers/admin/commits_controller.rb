class Admin::CommitsController < Admin::BaseController
  impressionist
  before_action :set_commit, only: [:show, :edit, :update, :destroy]
  before_action :default_format_html, only: :show

  def default_format_html
    request.format = "html"
  end

  # GET /commits
  # GET /commits.json
  def index_ssh
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

    if @user.present?
      if @user == current_user
        @repository = @user.repositories.friendly.find(params[:repository_id])
      else
        @repository = @user.repositories.public.friendly.find(params[:repository_id])
      end
    else
      @repository = nil
      raise ActionController::RoutingError.new('Repository Not Found')
    end

    # Read files
    require 'net/ssh'
    # require 'pp'
    require 'colorize'

    Net::SSH.start('git.lint.to', 'root', password: "b806d995ce24bfe8b30a8625fa") do |ssh|
      output = ssh.exec!("git --git-dir=/var/git/#{@repository.user.slug}/#{@repository.slug}.git log --date=iso --max-count=30")
      logs = output.split("commit ")
      logs.shift

      logs = logs.map do |log|
      # puts "@: #{log}".green
      l = log.split("\n")

      commit = l.shift

      if l[0].to_s.include? "Merge:"
        l.shift
      end

      author = l.shift.to_s.split("Author: ")[1]
      x = author.to_s.split(" ")
      email = x.pop
      name = x.join(' ')

      date = l.shift.to_s.split("Date: ")[1].to_s.strip
      message = l.join("\n").gsub("\n", '').strip
      {
      :hash => commit,
      :author => author,
      :name => name,
      :email => email,
      :date => date,
      :message => message
      }
      end

      @output = logs
      @commits = logs
    # pp logs



    # @output.split("\n").each do |line|
    #   words = line.split(' ')
    #   if !words[0].include?("fatal")
    #     commit = Commit.new
    #     commit.checksum_type = words[1]
    #     commit.checksum = words[2]
    #     commit.name = words[3]
    #     if commit.checksum_type == 'tree'
    #       commit.is_folder = true
    #     end
    #     if commit.checksum_type == 'blob'
    #       commit.is_folder = false
    #     end
    #     @repository.commits.push(commit)
    #   end
    # end
    end

  end


  # GET /commits
  # GET /commits.json
  def index
    repository_id = params[:repository_id]
    repository_id = params[:id] if params[:repository_id].blank?
    @repository = Repository.friendly.find(repository_id)
    if @repository.present?
      @repository = Repository.public.friendly.find(repository_id)
    else
     @repository = nil
     raise ActionController::RoutingError.new('Repository Not Found')
    end

    @commits = @repository.commits.order(date: :desc)

  end

  # GET /commits/1
  # GET /commits/1.json
  def show
   @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

   if @user.present?
     if @user == current_user
       @repository = @user.repositories.friendly.find(params[:repository_id])
     else
       @repository = @user.repositories.public.friendly.find(params[:repository_id])
     end
   else
     @repository = nil
     raise ActionController::RoutingError.new('Repository Not Found')
   end

  end

  # GET /commits/new
  def new
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

    if @user.present?
      if @user == current_user
        @repository = @user.repositories.friendly.find(params[:repository_id])
      else
        @repository = @user.repositories.public.friendly.find(params[:repository_id])
      end
    else
      @repository = nil
      raise ActionController::RoutingError.new('Repository Not Found')
    end

    @commit = Commit.new
    @form_url = admin_repository_commits_path
  end

  # GET /commits/1/edit
  def edit
  end

  # POST /commits
  # POST /commits.json
  def create
   @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

   if @user.present?
     if @user == current_user
       @repository = @user.repositories.friendly.find(params[:repository_id])
     else
       @repository = @user.repositories.public.friendly.find(params[:repository_id])
     end
   else
     @repository = nil
     raise ActionController::RoutingError.new('Repository Not Found')
   end

   @commit = Commit.new(commit_params)
   @commit.repository = @repository
   @commit.user = @user
   @form_url = admin_repository_commits_path(@user, @repository, @commit)

   respond_to do |format|
     if @commit.save
       format.html { redirect_to admin_repository_path(@repository, @commit), notice: 'Commit was successfully created.' }
       format.json { render :show, status: :created, location: admin_repository_path(@repository, @commit) }
     else
       format.html { render :new }
       format.json { render json: @commit.errors, status: :unprocessable_entity }
     end
   end
  end

  # PATCH/PUT /commits/1
  # PATCH/PUT /commits/1.json
  def update
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

    if @user.present?
      if @user == current_user
        @repository = @user.repositories.friendly.find(params[:repository_id])
      else
        @repository = @user.repositories.public.friendly.find(params[:repository_id])
      end
    else
      @repository = nil
      raise ActionController::RoutingError.new('Repository Not Found')
    end

    respond_to do |format|
      if @commit.update(commit_params)
        format.html { redirect_to user_repository_commit_path(@user, @repository, @commit), notice: 'Commit was successfully updated.' }
        format.json { render :show, status: :ok, location: user_repository_commit_path(@user, @repository, @commit) }
      else
        format.html { render :edit }
        format.json { render json: @commit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commits/1
  # DELETE /commits/1.json
  def destroy
   @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

   if @user.present?
     if @user == current_user
       @repository = @user.repositories.friendly.find(params[:repository_id])
     else
       @repository = @user.repositories.public.friendly.find(params[:repository_id])
     end
   else
     @repository = nil
     raise ActionController::RoutingError.new('Repository Not Found')
   end
   @commit.destroy
   respond_to do |format|
     format.html { redirect_to user_repository_path(@user, @repository), notice: 'Commit was successfully destroyed.' }
     format.json { head :no_content }
   end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commit
     @commit = Commit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commit_params
     params.require(:lint_commit).permit(:message,
     :date, :date_raw, :contributor_raw, :contributor_name, :contributor_email,
     :push_id, :contributor,
      data_set_users_attributes: [:user_id],
      data_set_repositories_attributes: [:repository_id])
    end
 end
