class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  rescue_from ActiveRecord::RecordNotSaved do |exception|
    render json: { errors: exception.message }, status: :unprocessable_entity
  end
end
