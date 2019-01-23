class MessagesController < ApplicationController


  # GET /contact
  # GET /messages/new
  def index
    @messages = Message.last(10)
    # @messages = current_user.messages
  end

  # GET /contact
  # GET /messages/new
  def new
    @message = Message.new()
  end

  # GET /messages/:id
  def show
    @message = Message.find(params[:id])    
  end


  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_thank_you_path }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /messages/thank-you
  def thank_you
  end


  private

    def message_params
      params.require(:message).permit(:name, :email, :message)
    end
end
