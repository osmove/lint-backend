# class CommitsController < ProtectedController
#   before_action :set_commit, only: [:show, :edit, :update, :destroy]
#
#   # GET /commits
#   # GET /commits.json
#   def index
#     @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
#
#     if @user.present?
#       if @user == current_user
#         @repository = @user.repositories.friendly.find(params[:repository_id])
#       else
#         @repository = @user.repositories.public.friendly.find(params[:repository_id])
#       end
#     else
#       @repository = nil
#       raise ActionController::RoutingError.new('Repository Not Found')
#     end
#
#     @commits = Commit.all.order(date: :asc)
#
#   end
#
#   # GET /commits/1
#   # GET /commits/1.json
#   def show
#     @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
#
#     if @user.present?
#       if @user == current_user
#         @repository = @user.repositories.friendly.find(params[:repository_id])
#       else
#         @repository = @user.repositories.public.friendly.find(params[:repository_id])
#       end
#     else
#       @repository = nil
#       raise ActionController::RoutingError.new('Repository Not Found')
#     end
#
#   end
#
#   # GET /commits/new
#   def new
#     @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
#
#     if @user.present?
#       if @user == current_user
#         @repository = @user.repositories.friendly.find(params[:repository_id])
#       else
#         @repository = @user.repositories.public.friendly.find(params[:repository_id])
#       end
#     else
#       @repository = nil
#       raise ActionController::RoutingError.new('Repository Not Found')
#     end
#     @commit = Commit.new
#     @form_url = user_repository_commits_path
#   end
#
#   # GET /commits/1/edit
#   def edit
#   end
#
#   # POST /commits
#   # POST /commits.json
#   def create
#     @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
#
#     if @user.present?
#       if @user == current_user
#         @repository = @user.repositories.friendly.find(params[:repository_id])
#       else
#         @repository = @user.repositories.public.friendly.find(params[:repository_id])
#       end
#     else
#       @repository = nil
#       raise ActionController::RoutingError.new('Repository Not Found')
#     end
#
#     @commit = Commit.new(commit_params)
#     @commit.repository = @repository
#     @commit.user = @user
#     @form_url = user_repository_commits_path(@user, @repository, @commit)
#
#     respond_to do |format|
#       if @commit.save
#         format.html { redirect_to user_repository_path(@user, @repository, @commit), notice: 'Commit was successfully created.' }
#         format.json { render :show, status: :created, location: user_repository_path(@user, @repository, @commit) }
#       else
#         format.html { render :new }
#         format.json { render json: @commit.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # PATCH/PUT /commits/1
#   # PATCH/PUT /commits/1.json
#   def update
#     @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
#
#     if @user.present?
#       if @user == current_user
#         @repository = @user.repositories.friendly.find(params[:repository_id])
#       else
#         @repository = @user.repositories.public.friendly.find(params[:repository_id])
#       end
#     else
#       @repository = nil
#       raise ActionController::RoutingError.new('Repository Not Found')
#     end
#     respond_to do |format|
#       if @commit.update(commit_params)
#         format.html { redirect_to user_repository_commit_path(@user, @repository, @commit), notice: 'Commit was successfully updated.' }
#         format.json { render :show, status: :ok, location: user_repository_commit_path(@user, @repository, @commit) }
#       else
#         format.html { render :edit }
#         format.json { render json: @commit.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # DELETE /commits/1
#   # DELETE /commits/1.json
#   def destroy
#     @user = params[:user_id] ? User.find_by(slug: params[:user_id].to_s.downcase) : current_user
#
#     if @user.present?
#       if @user == current_user
#         @repository = @user.repositories.friendly.find(params[:repository_id])
#       else
#         @repository = @user.repositories.public.friendly.find(params[:repository_id])
#       end
#     else
#       @repository = nil
#       raise ActionController::RoutingError.new('Repository Not Found')
#     end
#     @commit.destroy
#     respond_to do |format|
#       format.html { redirect_to user_repository_path(@user, @repository), notice: 'Commit was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end
#
#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_commit
#       @commit = Commit.find(params[:id])
#     end
#
#     # Never trust parameters from the scary internet, only allow the white list through.
#     def commit_params
#       params.require(:gatrix_commit).permit(:message,
#       :date, :date_raw, :contributor_raw, :contributor_name, :contributor_email,
#        data_set_users_attributes: [:user_id],
#        data_set_repositories_attributes: [:repository_id])
#     end
# end
