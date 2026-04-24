# class DocumentsController < ProtectedController
class DocumentsController < ApplicationController
  before_action :default_format_html, only: :show
  def default_format_html
    request.format = 'html'
  end

  # GET /documents
  # GET /documents.json
  def index
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user

    if @user.present?
      @repository = if @user == current_user
                      @user.repositories.friendly.find(params[:repository_id])
                    else
                      @user.repositories.public.friendly.find(params[:repository_id])
                    end
    else
      @repository = nil
      raise ActionController::RoutingError.new('Repository Not Found')
    end

    # Lists files in bare git repository
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
    #       document.name = words[3..-1].join(' ')
    #       if document.checksum_type == 'tree'
    #         document.is_folder = true
    #       end
    #       if document.checksum_type == 'blob'
    #         document.is_folder = false
    #       end
    #       @repository.documents.push(document)
    #     end
    #   end
    # end

    @documents = @repository.documents.sort_by { |d| [(!d.is_folder).to_s, d.name.downcase] }
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : nil
    if @user.present?
      @repository = if @user == current_user
                      @user.repositories.friendly.find(params[:repository_id])
                    else
                      @user.repositories.public.friendly.find(params[:repository_id])
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
    Net::SSH.start('git.lint.to', 'root', password: 'b806d995ce24bfe8b30a8625fa') do |ssh|
      @request = "git --git-dir=/var/git/#{@repository.uuid}.git show HEAD:'#{@document.name}'"
      @content = ssh.exec!(@request)
      @document.raw_content = @content
      # @document.content = @content
      @document.size = @content.length
      @document.extension = File.extname(@document.name)
      @document.extension.slice!(0)
    end

    # Check file type
    if @document.size > 2_000_000
      @document.type = 'error'
      @document.content = 'File is too big.'
    elsif @document.extension.present? && %w[exe bin dmg app].include?(@document.extension.downcase)
      @document.type = 'executable'
      @document.content = 'Executables are not supported.'
    elsif @document.extension.present? && %w[jpg jpeg png gif].include?(@document.extension.downcase)
      @document.type = 'image'
      @document.base_64_content = Base64.strict_encode64(@document.raw_content)
    elsif @document.extension.present? && %w[md markdown].include?(@document.extension.downcase)
      @document.type = 'markdown'
      require 'redcarpet'
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true,
                                                                  fenced_code_blocks: true)
      @document.content = markdown.render(@document.raw_content)
    elsif @document.extension.present? && %w[txt html xhtml htm rb erb php php5 js jsx
                                             yml xml].include?(@document.extension.downcase)
      @document.type = 'document'
      @document.content = @document.raw_content
    else
      @document.type = 'other'
      @document.content = @document.raw_content
    end
  end

  def create; end
end
