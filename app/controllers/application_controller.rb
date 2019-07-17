class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def oauth_authorize
    access_token = params["access_token"]
    Rails.logger.debug params
    data = GithubApi.user_access(session[:access_token])
    Rails.logger.debug data
  end

end
