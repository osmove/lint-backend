# class DocumentsController < ProtectedController
#   before_action :set_document, only: [:show, :edit, :update, :destroy]
#
#   # GET /documents
#   # GET /documents.json
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
#     @documents = Document.all
#   end
#
#   # GET /documents/1
#   # GET /documents/1.json
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
#   end
#
#   # GET /documents/new
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
#
#     @document = Document.new
#     @form_action = user_repository_documents_path(@user, @repository)
#   end
#
#   # GET /documents/1/edit
#   def edit
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
#     @form_action =  {:controller => "documents", :action => "update"}
#   end
#
#   # POST /documents
#   # POST /documents.json
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
#     @document = Document.new(document_params)
#     @document.repository = @repository
#     @form_action = user_repository_documents_path(@user, @repository, @document)
#
#
#     respond_to do |format|
#       if @document.save
#         format.html { redirect_to user_repository_documents_path(@user, @repository, @document), notice: 'Document was successfully created.' }
#         format.json { render :show, status: :created, location: user_repository_documents_path(@user, @repository, @document) }
#       else
#         format.html { render :new }
#         format.json { render json: @document.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # PATCH/PUT /documents/1
#   # PATCH/PUT /documents/1.json
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
#       if @document.update(document_params)
#         format.html { redirect_to user_repository_document_path(@user, @repository, @document), notice: 'Document was successfully updated.' }
#         format.json { render :show, status: :ok, location: user_repository_document_path(@user, @repository, @document) }
#       else
#         format.html { render :edit }
#         format.json { render json: @document.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # DELETE /documents/1
#   # DELETE /documents/1.json
#   def destroy
#     @document.destroy
#     respond_to do |format|
#       format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end
#
#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_document
#       @document = Document.find(params[:id])
#     end
#
#     # Never trust parameters from the scary internet, only allow the white list through.
#     def document_params
#       params.require(:document).permit(:name, :path, :is_folder, :size, :extension, :content, :repository, :document)
#     end
# end
