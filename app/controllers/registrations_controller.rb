class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  before_filter :override_params

  #lets just reimplement devise then I guess
  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
      else
        expire_data_after_sign_in!
      end
      render json: resource, status: 201 and return
    else
      clean_up_passwords(resource)
      render_errors(resource.errors)
    end
  end

  private

  def override_params
    params[:sign_up] = {
      email: json_api_params.require(:email),
      password: json_api_params.require(:password)
    }
  end

  def json_api_params
    params.require(:data).require(:attributes)
  end

  def sign_up_params
    allow = [:email, :password, :password_confirmation]
    params.require(:data).require(:attributes).permit(allow)
  end
end
