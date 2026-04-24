class Admin::RepositoriesController < Admin::BaseController

  before_action :set_repository, only: [:show, :edit, :update, :destroy, :qr_code, :settings]

  # before_action :authenticate_user!, only: :settings
  before_action :authenticate_user!, except: [:index, :show]

  # layout "bare", only: :qr_code


  # layout 'dashboard'
  # GET /repositories
  # GET /repositories.json
  def index
    @repositories = Repository.all.order(created_at: :desc).page(params[:page]).per(15)

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


  # GET /:user_id/:slug
  # GET /:user_id/:slug.json
  def show


    @user = nil
    # @user = params[:id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    if params[:user_id].present?
      @user = User.find_by(slug: params[:user_id])
      if @user
        @user.to_s.downcase
      end
    else
      params[:user_id] = @repository.user.id
    end
    # @commits = Commit.all.order(date: :desc).where(user: @user).where(repository: @repository)
    # @user



    require 'rqrcode'
    qrcode = RQRCode::QRCode.new("https://lint.to/#{@repository.uuid}")
    @qrcode_svg = qrcode.as_svg(offset: 0, color: '333', shape_rendering: 'crispEdges', module_size: 3)
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







  end




  # GET /:user_id/:slug/settings
  # GET /:user_id/:slug/settings.json
  def settings
    @user = nil
    # @user = params[:id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    if params[:user_id].present?
      @user = User.find_by(slug: params[:user_id])
      if @user
        @user.to_s.downcase
      end
    end
    # @commits = Commit.all.order(date: :desc).where(user: @user).where(repository: @repository)
    @user
  end



  # GET /repositories/new
  def new
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    @repository = Repository.new
    @form_url = user_repositories_path
  end

  # GET /repositories/1/edit
  def edit
    @author = @repository.user
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    if @author = @user
      @form_url =  {:controller => "repositories", :action => "update"}
    end
  end

  # POST /repositories
  # POST /repositories.json
  def create
    @form_url = user_repositories_path
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    @repository = Repository.new(repository_params)
    @repository.user = @user
    @repository.slug = @repository.name.to_s.parameterize(separator: "-", preserve_case: false)

    respond_to do |format|
      if @repository.save
        format.html do
 redirect_to user_repository_path(@user, @repository), notice: 'Repository was successfully created.'
        end
        format.json { render :show, status: :created, location: user_repository_path(@user, @repository) }
      else
        format.html { render :new }
        format.json { render json: user_repository_path(@user, @repository), status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repositories/1
  # PATCH/PUT /repositories/1.json
  def update

    @repository.user = @user


    respond_to do |format|
      if @repository.update(repository_params)

        @repository.slug = @repository.name.to_s.parameterize(separator: "-", preserve_case: false)
        format.html do
 redirect_to user_repository_path(@user, @repository), notice: 'Repository was successfully updated.'
        end
        format.json { render :show, status: :ok, location: user_repository_path(@user) }
      else
        format.html { render :edit }
        format.json { render json: user_repositories_path(@user).errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repositories/1
  # DELETE /repositories/1.json


  def destroy
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    @repository = @user.repositories.friendly.find(params[:repository_id])
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
      @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
      repository_id = params[:repository_id]
      repository_id = params[:id] if params[:repository_id].blank?
      @repository = Repository.friendly.find(repository_id)
      if @repository.present?
        @repository = Repository.public.friendly.find(repository_id)
      else
        # @repository = nil
        raise ActionController::RoutingError.new('Repository Not Found')
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repository_params
      params.require(:repository).permit(:name, :slug, :user_id, :status, :deploy_to, :server_size, :domain_slug, :geo_zone, :hosting_plan_id, :type, :platform_id, :has_encryption, :has_deployment, :requires_two_step_authentication, :policy_id, :git_host,
        :git_address, :has_autofix, :web_url, :html_url, :git_url, :ssh_url)
    end
end
