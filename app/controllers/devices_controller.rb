class DevicesController < ApplicationController

  impressionist

  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/push-token
  def push_token
    @push_api_key = params[:push_api_key]
    if params[:push_api_key] == '9GQL8sdfuSh2iu3nlfifjnA0DF13283DFG01n32FS102912n2diSF12odn08n'
      @token = params[:token]
      @username = params[:user]
      if @token.present?
        @device = Device.find_by(push_token: @token)
        @user = User.find_by(slug: @username)
        if @device.present?
          if user_signed_in? && @device.user != current_user
            @device.update!(user: current_user)
          end
        else
          if user_signed_in?
            @device = Device.create!(push_token: @token, user: current_user)
          else
            @device = Device.create!(push_token: @token)
          end
        end
      end
      render json: @token, status: :created
    else
      render json: {status: 'not_authorized'}, status: :unauthorized
    end
  end


  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:user_id, :type, :brand, :model, :sub_model, :uuid, :os, :os_version, :has_notifications, :has_gatrix_desktop, :has_gatrix_connect, :last_seen, :browser, :user_agent, :push_token)
    end
end
