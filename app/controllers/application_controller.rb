class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :authenticate_user_from_token!

  #Enter the normal Devise authentication path,
  #using the token authenticaed user if available
  before_filter :authenticate_user!

  private

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end

  def json_api_params
    params.require(:data).require(:attributes)
  end

  def render_errors(active_model_errors, options = {})
    status = options[:status] || 422
    errors = active_model_errors.messages.map do |message|
      pointer = "/data/attributes/#{message[0]}"
      detail = message[1]
      Error.new(pointer: pointer, detail: detail, status: status)
    end
    render json: errors, each_serializer: ErrorSerializer, status: status
  end
end
