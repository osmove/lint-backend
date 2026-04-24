class IssueMessagesController < ProtectedController


  before_action :set_issue_message, only: [:show, :edit, :update, :destroy]

  # GET /issue_messages
  # GET /issue_messages.json
  def index
    @issue_messages = IssueMessage.all
  end

  # GET /issue_messages/1
  # GET /issue_messages/1.json
  def show
  end

  # GET /issue_messages/new
  def new
    @issue_message = IssueMessage.new
  end

  # GET /issue_messages/1/edit
  def edit
  end

  # POST /issue_messages
  # POST /issue_messages.json
  def create
    @issue_message = IssueMessage.new(issue_message_params)

    respond_to do |format|
      if @issue_message.save
        format.html { redirect_to @issue_message, notice: 'Issue message was successfully created.' }
        format.json { render :show, status: :created, location: @issue_message }
      else
        format.html { render :new }
        format.json { render json: @issue_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issue_messages/1
  # PATCH/PUT /issue_messages/1.json
  def update
    respond_to do |format|
      if @issue_message.update(issue_message_params)
        format.html { redirect_to @issue_message, notice: 'Issue message was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue_message }
      else
        format.html { render :edit }
        format.json { render json: @issue_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issue_messages/1
  # DELETE /issue_messages/1.json
  def destroy
    @issue_message.destroy
    respond_to do |format|
      format.html { redirect_to issue_messages_url, notice: 'Issue message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue_message
      @issue_message = IssueMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_message_params
      params.require(:issue_message).permit(:title, :slug, :body, :username, :issue_id, :repository_id, :user_id)
    end
end
