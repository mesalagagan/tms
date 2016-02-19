class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_request


  def layout_by_resource
    if signed_in?
      'application'
    else
      'home'
    end
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :dob, :company_name, :avatar) }
  end

  private
  def set_request
    $base_url = request.base_url
  end

end
