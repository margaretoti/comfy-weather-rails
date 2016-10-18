class V1::UsersController < ApplicationController
  def index
    users = User.all

    render json: users
  end

  def show
    user = User.find(params[:id])

    render json: user
  end

  def create
    @graph = Koala::Facebook::API.new(params[:access_token])
    user_data = @graph.get_object("me?fields=name,picture,id")
    user = User.populating_from_koala(user_data)
    user.reset_token!

    render json: user
  end

  def update
    user = User.find(params[:id])
    user.update!(user_params)

    render json: user
  end

  def destroy
    current_user.auth_expires_at = Time.now
    current_user.save!

    head :no_content
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :gender, :preferred_time, :weather_perception,
              :avatar, :auth_token, :auth_expires_at)
  end
end
