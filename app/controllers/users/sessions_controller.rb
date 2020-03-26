# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: %i[create destroy]
  after_action :after_login, only: :create

  layout 'devise'

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    return redirect_to users_path unless verify_rucaptcha?

    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  private

  def after_login
    UserLogin.create(ip: current_user.last_sign_in_ip, user_id: current_user.id, phone: current_user.phone)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #  devise_parameter_sanitizer.permit(:sign_in, keys: [:longin_name])
  # end
end
