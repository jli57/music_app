class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def log_out_user!(user)
    user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def require_logout
    redirect_to bands_url if logged_in?
  end
end
