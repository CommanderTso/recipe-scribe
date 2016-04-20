class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to login_path unless current_user
  end

  def get_errors(erroneous_object)
    error_message = erroneous_object.errors.full_messages.join(", ")
    error_message += "."
    error_message
  end
end
