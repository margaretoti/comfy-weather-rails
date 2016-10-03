class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotSaved do |exception|
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotSaved do |exception|
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  rescue_from Koala::Facebook::AuthenticationError do |exception|
    render json: { errors: exception.message }, status: :bad_request
  end
end
