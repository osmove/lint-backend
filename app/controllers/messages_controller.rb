class MessagesController < ApplicationController
  # GET /contact
  # GET /messages/new
  def index
    @messages = Message.order(id: :desc).limit(20)
    # @messages = current_user.messages
  end

  # GET /messages/:id
  def show
    @message = Message.find(params[:id])
    @message.read = true
    @message.save
  end

  # GET /contact
  # GET /messages/new
  def new
    @message = Message.new
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
        format.json { render json: @message.errors, status: :unprocessable_content }
      end
    end
  end

  # GET /messages/thank-you
  def thank_you; end

private

  def message_params
    params.require(:message).permit(:name, :email, :text_body)
  end
end
