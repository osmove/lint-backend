class AuthController < ProtectedController
  def is_signed_in?
    if user_signed_in?
      render json: { 'signed_in' => true, 'user' => current_user }.to_json
    else
      render json: { 'signed_in' => false }.to_json
    end
  end

  def me
    if user_signed_in?
      @signed_in = true
      @user = current_user
      # @settings = Setting.get_all
    else
      @signed_in = false
      @user = nil
    end
  end
end
