class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  #rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private
  def record_not_found
    render plain: "404 Not Found", status: 404
  end
end
