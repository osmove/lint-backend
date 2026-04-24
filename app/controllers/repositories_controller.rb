class RepositoriesController < ProtectedController
  # class RepositoriesController < ApplicationController
  before_action :set_repository, only: %i[show edit update destroy qr_code settings repository_policies]

  # before_action :authenticate_user!, only: :settings
  before_action :authenticate_user!, except: %i[index show]

  # layout "bare", only: :qr_code

  # layout 'dashboard'
  # GET /repositories
  # GET /repositories.json
  def index
    @owner = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : nil

    @my_repositories = []
    if params['q'].present? && params['q'] != '' && params['q'] != 'undefined'
      @query = params['q']
      @repositories = if params[:user_id].present? && params[:user_id] != ''
                        Repository.where(user: @owner).where('uuid LIKE ?', "%#{@query.downcase}%")
                      else
                        Repository.all.public.where(user: !@owner).where('uuid LIKE ?', "%#{@query.downcase}%")
                      end
    elsif params[:user_id].present?
      @repositories = Repository.where(user: @owner)
    else
      @repositories = Repository.all
    end

    if params['git_url'].present? && params['git_url'] != '' && params['git_url'] != 'undefined'
      @query = params['git_url']
      @repositories = if params[:user_id].present? && params[:user_id] != ''
                        Repository.where(user: @owner).where('lower(git_address) LIKE ?', "%#{@query.downcase}%")
                      else
                        Repository.all.public.where(user: @owner).where('lower(git_address) LIKE ?',
                                                                        "%#{@query.downcase}%")
                      end
    elsif params[:user_id].present?
      @repositories = Repository.where(user: @owner)
    else
      @repositories = Repository.all
    end

    if params['slug'].present? && params['slug'] != '' && params['slug'] != 'undefined'
      @query = params['slug']
      @repositories = if params[:user_id].present? && params[:user_id] != ''
                        Repository.where(user: @owner).where('lower(slug) = ?', @query.downcase.to_s)
                      else
                        Repository.all.public.where(user: @owner).where('lower(slug) = ?', @query.downcase.to_s)
                      end
    elsif params[:user_id].present?
      @repositories = Repository.where(user: @owner)
    else
      @repositories = Repository.all
    end

    @repositories_count = @repositories.count
    @repositories = @repositories.order(created_at: :desc)
    # @repositories = @repositories.limit(5).order(updated_at: :desc)
    fresh_when etag: @repositories
  end

  # GET /:user_id/:slug/qr_code
  # GET /:user_id/:slug/qr_code.json
  def qr_code
    require 'net/ssh'
    # @device = Device.find(params[:id])
    require 'rqrcode'
    @qr_code = RQRCode::QRCode.new(@repository.uuid)
    @qr_code_svg = qr_code.as_svg(offset: 0, color: '000', shape_rendering: 'crispEdges', module_size: 5)
    # respond_to do |format|
    #   html = "<html><head></head><body style=\"text-align: center;\">#{@svg}</body></html>"
    #   format.html { render :text => html}
    #   # format.html { render :text => @model_object.html_content }
    # end
  end

  def repository_policies
    # repository_slug = params[:repository_id] || params[:id]
    # user_slug = params[:user_id]
    # puts ''
    # puts repository_slug
    # puts user_slug
    #
    # puts ''

    # if repository_slug.present? && user_slug.present?
    #   @repository = Repository.includes( policy: { policy_rules: [{rule: :linter}, { policy_rule_options: :rule_option }]}).where(uuid: "#{user_slug}/#{repository_slug}").first rescue nil
    #   # @repository = Repository.includes( policy: { policy_rules: [{rule: :linter}, { policy_rule_options: [:rule_option, :rule_option_options ] }]}).where(uuid: "#{user_slug}/#{repository_slug}").first rescue nil
    #   # @policy = @repository.policy
    # else
    #   raise ActionController::RoutingError.new('Repository Not Found')
    # end
    # @repository = Repository.includes( policy: { policy_rules: [{rule: :linter}, { policy_rule_options: :rule_option }]}).where(uuid: @repository.uuid).first rescue nil
    # @repository = Repository.includes( policy: { policy_rules: [{rule: :linter}, { policy_rule_options: :rule_option }]}).where(uuid: @repository.uuid).first rescue nil

    if @repository.present?
      @repository = begin
        Repository.includes(policy: { policy_rules: %i[linter
                                                       policy_rule_options] }).where(uuid: @repository.uuid).first
      rescue StandardError
        nil
      end
    end

    @policy = @repository.policy
    # @policy_rules = @policy.policy_rules.order(name: :asc)
    # @policy_rules_grouped_by_linter = @policy.policy_rules.order(name: :asc).group_by{|h| h.linter}

    @linters = Linter.all
    @form_url = user_repository_path(@repository.user, @repository)
    fresh_when @policy
  end

  # GET /:user_id/:slug
  # GET /:user_id/:slug.json
  def show
    @owner = nil
    # @owner = params[:id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    if params[:user_id].present?
      @owner = User.find_by(slug: params[:user_id])
      @owner&.to_s&.downcase
    end
    # @commits = Commit.all.order(date: :desc).where(user: @owner).where(repository: @repository)

    # require 'rqrcode'
    # qrcode = RQRCode::QRCode.new("https://lint.to/#{@repository.uuid}")
    # @qrcode_svg = qrcode.as_svg(offset: 0, color: '333', shape_rendering: 'crispEdges', module_size: 3)

    # @qrcode_html = qrcode.as_html

    # List files in bare repository
    # require 'net/ssh'
    # Net::SSH.start('git.lint.to', 'root', password: "b806d995ce24bfe8b30a8625fa") do |ssh|
    #   # @output = ssh.exec!("git --git-dir=/var/git/#{@repository.user.slug}/#{@repository.slug}.git ls-tree --full-tree -r HEAD")
    #   @output = ssh.exec!("git --git-dir=/var/git/#{@repository.user.slug}/#{@repository.slug}.git ls-tree HEAD")
    #   @output.split("\n").each do |line|
    #     words = line.split(' ')
    #     if !words[0].include?("fatal")
    #       document = Document.new
    #       document.checksum_type = words[1]
    #       document.checksum = words[2]
    #       document.name = words[3]
    #       if document.checksum_type == 'tree'
    #         document.is_folder = true
    #       end
    #       if document.checksum_type == 'blob'
    #         document.is_folder = false
    #       end
    #       @repository.documents.push(document)
    #     end
    #   end
    #
    #   @documents = @repository.documents.sort_by{ |d| [(!d.is_folder).to_s, d.name.downcase] }
    #
    #   if @documents.map(&:name).include?('README.md')
    #     # Read README,md file
    #     @readme = Document.new
    #     @readme.name = 'README.md'
    #     @readme.path = 'README.md'
    #     @readme.extension = 'md'
    #     @request2 = "git --git-dir=/var/git/#{@repository.uuid}.git show HEAD:'#{@readme.name}'"
    #     @content2 = ssh.exec!(@request2)
    #     @readme.raw_content = @content2
    #     # @readme.content = @content2
    #     @readme.size = @content2.length
    #
    #     # Check file type
    #     if @readme.size > 2000000
    #       @readme.type = 'error'
    #       @readme.content = 'File is too big.'
    #     else
    #       @readme.content = @readme.raw_content
    #       @readme.type = 'markdown'
    #       require 'redcarpet'
    #       markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, fenced_code_blocks: true)
    #       @readme.content = markdown.render(@readme.raw_content)
    #     end
    #   else
    #     @readme = false
    #   end
    #
    #
    #
    #
    #
    # end

    #
    # if @repository.documents.map(&:name).include?('README.md')
    #   # Read README,md file
    #   @readme = Document.new
    #   @readme.name = 'README.md'
    #   @readme.path = 'README.md'
    #   @readme.extension = 'md'
    #   Net::SSH.start('git.lint.to', 'root', password: "b806d995ce24bfe8b30a8625fa") do |ssh|
    #     @request2 = "git --git-dir=/var/git/#{@repository.uuid}.git show HEAD:'#{@readme.name}'"
    #     @content2 = ssh.exec!(@request2)
    #     @readme.raw_content = @content2
    #     # @readme.content = @content2
    #     @readme.size = @content2.length
    #
    #     # Check file type
    #     if @readme.size > 2000000
    #       @readme.type = 'error'
    #       @readme.content = 'File is too big.'
    #     else
    #       @readme.content = @readme.raw_content
    #       @readme.type = 'markdown'
    #       require 'redcarpet'
    #       markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, fenced_code_blocks: true)
    #       @readme.content = markdown.render(@readme.raw_content)
    #     end
    #   end
    # else
    #   @readme = false
    # end

    #
    # repository_slug = params[:repository_id] || params[:id]
    # user_slug = params[:user_id]
    #
    # if repository_slug.present? && user_slug.present?
    #   @repository = Repository.where(uuid: "#{user_slug}/#{repository_slug}").first rescue nil
    # else
    #   raise ActionController::RoutingError.new('Repository Not Found')
    # end

    if @repository.present?
      @languages = Language.all
      @commit_attempts = @repository.commit_attempts.includes(:policy_checks)
      @commit_attempts_count = @repository.commit_attempts.order(created_at: :desc).count

      @authors = @commit_attempts.filter_map(&:user).uniq
      @branches = @commit_attempts.filter_map(&:branch_name).uniq

      if params[:author].present?
        @author = params[:author]
        @commit_attempts = @commit_attempts.where(user_id: @author).includes(:policy_checks)
      end

      if params[:branch].present?
        @branch = params[:branch].gsub(/[^a-zA-Z0-9-]/, '')
        @commit_attempts = @commit_attempts.where(branch_name: @branch).includes(:policy_checks)
        # @commit_attempts = @commit_attempts.where("lower(name) = ?", name.downcase).includes(:policy_checks).order(created_at: :desc).page(params[:page]).per(10)
      end

      if params[:status].present?
        # @status = params[:status]
        if params[:status] == 'passed'
          @commit_attempts = @commit_attempts.where(passed: true)
        elsif params[:status] == 'failed'
          @commit_attempts = @commit_attempts.where(passed: false)
        end
      end
    else
      @commit_attempts = CommitAttempt.includes(:policy_checks)
      @commit_attempts_count = @commit_attempts.count
    end

    @commit_attempts = @commit_attempts.order(created_at: :desc).page(params[:page]).per(10)
    fresh_when etag: @commit_attempts
  end

  # GET /:user_id/:slug/settings
  # GET /:user_id/:slug/settings.json
  def settings
    @owner = nil
    # @owner = params[:id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    if params[:user_id].present?
      @owner = User.find_by(slug: params[:user_id])
      @owner&.to_s&.downcase
    end
    # @commits = Commit.all.order(date: :desc).where(user: @owner).where(repository: @repository)
    @owner
  end

  # GET /repositories/new
  def new
    @owner = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    @repository = Repository.new
    @form_url = user_repositories_path
  end

  # GET /repositories/1/edit
  def edit
    # @author = @repository.user
    # @owner = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    # if @author == @owner
    #   @form_url =  {:controller => "repositories", :action => "update"}
    # end

    # @form_url =  {:controller => "repositories", :action => "update"}

    @form_url = user_repository_path(@repository.user, @repository)
  end

  # POST /repositories
  # POST /repositories.json
  def create
    @form_url = user_repositories_path
    # @owner = current_user
    @repository = Repository.new(repository_params)
    @repository.user = current_user
    uuid = "#{@repository.user.slug}/#{@repository.slug}"
    # puts "uuid"
    # puts uuid
    # uuid = "#{@repository.user.username.to_s.downcase}/#{@repository.name.to_s.downcase}"
    # uuid = @repository.uuid

    @repository.slug = @repository.name.to_s.downcase

    respond_to do |format|
      if Repository.where(uuid: uuid).first.present?
        @repository.errors.add(:uuid, 'already exists')
        format.html { render :new, alert: 'Repository already exists.' }
        format.json { render json: user_repository_path(@repository.user, @repository), status: :unprocessable_content }
      else
        @repository.git_address = if @repository.git_host == 'github'
                                    git_url
                                  else
                                    "git@git.lint.to:#{@repository.user.slug}/#{@repository.slug}.git"
                                  end
        if @repository.save
          format.html do
            redirect_to user_repository_path(@repository.user, @repository),
                        notice: 'Repository was successfully created.'
          end
          format.json { render :show, status: :created, location: user_repository_path(@repository.user, @repository) }
        else
          format.html { render :new }
          format.json do
            render json: user_repository_path(@repository.user, @repository), status: :unprocessable_content
          end
        end
      end
    end
  end

  # PATCH/PUT /repositories/1
  # PATCH/PUT /repositories/1.json
  def update
    # @repository.user = @owner
    respond_to do |format|
      if @repository.update(repository_params)
        @repository.slug = @repository.name.to_s.downcase

        format.html { redirect_to request.referer, notice: 'Repository was successfully updated.' }
        format.json { render :show, status: :ok, location: request.referer }
      else
        format.html { render :edit }
        format.json do
          render json: user_repositories_path(@repository.user, @repository).errors, status: :unprocessable_content
        end
      end
    end
  end

  # DELETE /repositories/1
  # DELETE /repositories/1.json

  def destroy
    @owner = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    @repository = @owner.repositories.friendly.find(params[:repository_id])
    @repository.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Repository was successfully destroyed.' }
      # format.html { redirect_to user_repositories_url, notice: 'Repository was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_repository
    repository_slug = params[:repository_id] || params[:id]
    user_slug = params[:user_id]
    raise ActionController::RoutingError, 'Repository Not Found' unless repository_slug.present? && user_slug.present?

    @repository = begin
      Repository.where(uuid: "#{user_slug}/#{repository_slug}").first
    rescue StandardError
      nil
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def repository_params
    params.expect(repository: %i[id name slug user_id status deploy_to server_size domain_slug geo_zone hosting_plan_id type platform_id has_encryption has_deployment requires_two_step_authentication policy_id git_host
                                 git_address has_autofix web_url html_url git_url ssh_url])
  end
end
