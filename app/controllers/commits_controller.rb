# class CommitsController < ProtectedController
class CommitsController < ApplicationController


  impressionist


  before_action :authenticate_user!, except: [:index, :show]


  before_action :default_format_html, only: :show
  def default_format_html
    request.format = "html"
  end


  # GET /commits
  # GET /commits.json
  def index
    repository_slug = params[:repository_id] || params[:id]
    user_slug = params[:user_id]
    puts ''
    puts repository_slug
    puts user_slug

    puts ''

    if repository_slug.present? && user_slug.present?
      @repository = Repository.where(uuid: "#{user_slug}/#{repository_slug}").first rescue nil
    else
      raise ActionController::RoutingError.new('Repository Not Found')
    end

    # Read files
    require 'net/ssh'
    # require 'pp'
    require 'colorize'
    # if @repository.git_host == "omnilint"
    #
    #   Net::SSH.start('git.omnilint.com', 'root', password: "b806d995ce24bfe8b30a8625fa") do |ssh|
    #     output = ssh.exec!("git --git-dir=/var/git/#{@repository.user.slug}/#{@repository.slug}.git log --date=iso --max-count=30")
    #     logs = output.split("commit ")
    #     logs.shift
    #
    #     logs = logs.map do |log|
    #       # puts "@: #{log}".green
    #       l = log.split("\n")
    #
    #       commit = l.shift
    #
    #       if l[0].to_s.include? "Merge:"
    #         l.shift
    #       end
    #
    #       author = l.shift.to_s.split("Author: ")[1]
    #       x = author.to_s.split(" ")
    #       email = x.pop
    #       name = x.join(' ')
    #
    #       date = l.shift.to_s.split("Date: ")[1].to_s.strip
    #       message = l.join("\n").gsub("\n", '').strip
    #       {
    #         :hash => commit,
    #         :author => author,
    #         :name => name,
    #         :email => email,
    #         :date => date,
    #         :message => message
    #       }
    #     end
    #   end
    #   @output = logs
    #   @commits = logs
    #   # pp logs
    #
    #
    #
    #   # @output.split("\n").each do |line|
    #   #   words = line.split(' ')
    #   #   if !words[0].include?("fatal")
    #   #     commit = Commit.new
    #   #     commit.checksum_type = words[1]
    #   #     commit.checksum = words[2]
    #   #     commit.name = words[3]
    #   #     if commit.checksum_type == 'tree'
    #   #       commit.is_folder = true
    #   #     end
    #   #     if commit.checksum_type == 'blob'
    #   #       commit.is_folder = false
    #   #     end
    #   #     @repository.commits.push(commit)
    #   #   end
    #   # end
    # else
      @commits = @repository.commits.includes(:commit_attempts).order(created_at: :desc)
    # end
    fresh_when etag: @commits
  end



  # GET /commits/1
  # GET /commits/1.json
  def show

    repository_slug = params[:repository_id] || params[:id]
    user_slug = params[:user_id]
    puts ''
    puts repository_slug
    puts user_slug

    puts ''

    if repository_slug.present? && user_slug.present?
      @repository = Repository.where(uuid: "#{user_slug}/#{repository_slug}").first rescue nil
    else
      raise ActionController::RoutingError.new('Repository Not Found')
    end

    @commit = @repository.commits.find(params[:id])
    # @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : nil
    # if @user.present?
    #   if @user == current_user
    #     @repository = @user.repositories.friendly.find(params[:repository_id])
    #   else
    #     @repository = @user.repositories.public.friendly.find(params[:repository_id])
    #   end
    # else
    #   @repository = nil
    #   raise ActionController::RoutingError.new('Repository Not Found')
    # end
    #
    # @commit = Commit.new
    # @commit.name = params[:id]
    # @commit.path = params[:id]

    # Read file content
    # require 'net/ssh'
    # Net::SSH.start('git.omnilint.com', 'root', password: "b806d995ce24bfe8b30a8625fa") do |ssh|
    #   @content = ssh.exec!("git --git-dir=/var/git/#{@repository.uuid}.git show HEAD:#{@commit.name}")
    #   @commit.content = @content
    #   @commit.size = @content.length
    #   @commit.extension = File.extname(@commit.name)
    #   @commit.extension.slice!(0)
    # end


  end

  private

end
