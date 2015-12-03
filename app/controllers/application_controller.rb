class ApplicationController < ActionController::Base
  before_action :ensure_signup_complete
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to new_user_session_path, alert: exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :chatwork_id]
    devise_parameter_sanitizer.for(:account_update) << [:name, :chatwork_id]
  end

  def load_subjects
    @subjects = Subject.all
  end

  def ensure_signup_complete
    return if action_name == "finish_signup"
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path current_user
    end
  end
end
