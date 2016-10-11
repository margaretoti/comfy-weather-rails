class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotSaved do |exception|
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { errors: exception.message }, status: :bad_request
  end

  rescue_from ArgumentError do |exception|
    render json: { errors: exception.message }, status: :bad_request
  end

  rescue_from Koala::Facebook::AuthenticationError do |exception|
    render json: { errors: exception.message }, status: :bad_request
  end

  private
  def current_user
    request.env['warden'].user
  end
  helper_method :current_user
end
