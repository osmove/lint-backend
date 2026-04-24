# class DocumentsController < ProtectedController
class Admin::DocumentsController < Admin::BaseController
  require "open-uri"

  before_action :set_document, only: [:show, :edit, :update, :destroy]

  impressionist


  before_action :default_format_html, only: :show
  def default_format_html
    request.format = "html"
  end


  # GET /documents
  # GET /documents.json
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

    # Lists files in bare git repository
    require 'net/ssh'
    Net::SSH.start('git.lint.to', 'root', password: "b806d995ce24bfe8b30a8625fa") do |ssh|
      # @output = ssh.exec!("git --git-dir=/var/git/#{@repository.user.slug}/#{@repository.slug}.git ls-tree --full-tree -r HEAD")
      @output = ssh.exec!("git --git-dir=/var/git/#{@repository.user.slug}/#{@repository.slug}.git ls-tree HEAD")
      @output.split("\n").each do |line|
        words = line.split(' ')
        if !words[0].include?("fatal")
          document = Document.new
          document.checksum_type = words[1]
          document.checksum = words[2]
          document.name = words[3..-1].join(' ')
          if document.checksum_type == 'tree'
            document.is_folder = true
          end
          if document.checksum_type == 'blob'
            document.is_folder = false
          end
          @repository.documents.push(document)
        end
      end
    end

    @documents = @repository.documents.sort_by{ |d| [(!d.is_folder).to_s, d.name.downcase] }

  end



  # GET /documents/1
  # GET /documents/1.json
  def show_ssh

    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : nil
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

    @document = Document.new
    @document.name = params[:id]
    @document.path = params[:id]

    # Read file content
    require 'net/ssh'
    Net::SSH.start('git.lint.to', 'root', password: "b806d995ce24bfe8b30a8625fa") do |ssh|
      @request = "git --git-dir=/var/git/#{@repository.uuid}.git show HEAD:'#{@document.name}'"
      @content = ssh.exec!(@request)
      @document.raw_content = @content
      # @document.content = @content
      @document.size = @content.length
      @document.extension = File.extname(@document.name)
      @document.extension.slice!(0)
    end


    # Check file type
    if @document.size > 2000000
      @document.type = 'error'
      @document.content = 'File is too big.'
    elsif @document.extension.present? && ['exe', 'bin', 'dmg', 'app'].include?(@document.extension.downcase)
      @document.type = 'executable'
      @document.content = 'Executables are not supported.'
    elsif @document.extension.present? && ['jpg', 'jpeg', 'png', 'gif'].include?(@document.extension.downcase)
      @document.type = 'image'
      @document.base_64_content = Base64.strict_encode64(@document.raw_content)
    elsif @document.extension.present? && ['md', 'markdown'].include?(@document.extension.downcase)
      @document.type = 'markdown'
      require 'redcarpet'
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, 
                                                                  fenced_code_blocks: true)
      @document.content = markdown.render(@document.raw_content)
    elsif @document.extension.present? && ['txt', 'html', 'xhtml', 'htm', 'rb', 'erb', 'php', 'php5', 'js', 'jsx',
                                           'yml', 'xml'].include?(@document.extension.downcase)
      @document.type = 'document'
      @document.content = @document.raw_content
    else
      @document.type = 'other'
      @document.content = @document.raw_content
    end



  end


  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # # GET /documents
  # # GET /documents.json
  # def index
  #   @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
  #
  #   if @user.present?
  #     if @user == current_user
  #       @repository = @user.repositories.friendly.find(params[:repository_id])
  #     else
  #       @repository = @user.repositories.public.friendly.find(params[:repository_id])
  #     end
  #   else
  #     @repository = nil
  #     raise ActionController::RoutingError.new('Repository Not Found')
  #   end
  #   @documents = Document.all
  # end

  # GET /documents
  # GET /documents.json
  def index
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
    # Get Documents with github API
    if @user.present?
      if @user == current_user
        @repository = Repository.friendly.find(params[:repository_id])
      else
        @repository = @user.repositories.public.friendly.find(params[:repository_id])
      end
    else
      @repository = nil
      raise ActionController::RoutingError.new('Repository Not Found')
    end

    if @repository.git_host == "github"
      @url = "https://api.github.com/repos/#{@repository.uuid}/contents/"
      puts(@url)
      files_json = URI.open(@url,
        "Accept" => "application/vnd.github.v3+json",
        "Authorization" => "token #{current_user.oauth_token}"
      ).read

      if files_json != nil
        files = JSON.parse(files_json)
        puts(files)
        files.each do |file|
          if Document.where(repository: @repository, name: file["name"], path: file["path"]).blank?
            if file["type"] == "file"
              @is_folder = false
              @file_type = "file"
            elsif file["type"] == "dir"
              @is_folder = true
              @file_type = "dir"
            end
            @file = @repository.documents.new(
              name: file["name"],
              path: file["path"],
              is_folder: @is_folder,
              size: file["size"],
              extension: file["name"].partition('.').last,
              type: @file_type
            )
            if !@file.save!
              puts(@file.errors.full_messages)
            end
          else
            @file = Document.where(repository: @repository, name: file["name"]).first
          end
          # @repository.commits.push(@commit)
        end
      end
    end
    @documents = @repository.documents.where(document_id: nil)
  end

  # GET /documents/1
  # GET /documents/1.json
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

    @document = Document.find(params[:id])

    if @document.is_folder?
      file_content_json = URI.open("https://api.github.com/repos/#{@repository.uuid}/contents/#{@document.path}",
        "Accept" => "application/vnd.github.v3+json",
        "Authorization" => "token #{@user.oauth_token}"
      ).read
      files_content = JSON.parse(file_content_json)

      puts(file_content_json)

      files_content.each do |content|
        if content["type"] == "file"
          @is_folder = false
          @file_type = "file"
        elsif content["type"] == "dir"
          @is_folder = true
          @file_type = "dir"
        end
        if Document.where(name: content["name"], document: @document, path: content["path"], is_folder: @is_folder, repository:
          @document.repository, size: content["size"], extension: content["name"].partition('.').last, type: @file_type).count == 0

          @content = Document.new(
            name: content["name"],
            document: @document,
            path: content["path"],
            is_folder: @is_folder,
            repository: @document.repository,
            size: content["size"],
            extension: content["name"].partition('.').last,
            type: @file_type
          )
          if !@content.save!
            puts(@content.errors.full_messages)
          end
        end
      end
      @file_contents = Document.where(document: @document, repository: @repository)
    else
      @file_contents = nil
    end
  end

  # GET /documents/new
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

    @document = Document.new
    @form_action = admin_repository_documents_path
  end

  # GET /documents/1/edit
  def edit
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

    @form_action =  {:controller => "documents", :action => "update"}
  end

  # POST /documents
  # POST /documents.json
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

    @document = Document.new(document_params)
    @document.repository = @repository
    @form_action = user_repository_documents_path(@user, @repository, @document)


    respond_to do |format|
      if @document.save
        format.html do
 redirect_to admin_repository_documents_path(@repository, @document), notice: 'Document was successfully created.'
        end
        format.json { render :show, status: :created, location: admin_repository_documents_path(@repository, @document)}
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
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
      if @document.update(document_params)
        format.html do
 redirect_to admin_repository_documents_path(@repository, @document), notice: 'Document was successfully updated.'
        end
        format.json { render :show, status: :ok, location: admin_repository_documents_path(@repository, @document) }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find_by(slug: params[:id].to_s.downcase)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :path, :is_folder, :size, :extension, :content, :repository, :document)
    end


end
