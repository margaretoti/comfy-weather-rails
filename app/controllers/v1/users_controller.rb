class V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def create
    @graph = Koala::Facebook::API.new(params[:access_token])
    user_data = @graph.get_object("me?fields=name,picture,id")
    user = User.populating_from_koala(user_data)
    user.oauth_token = params[:access_token]
    user.oauth_expires_at = 60.days.from_now
    user.save!
    session[:user_id] = user.id
    render json: user
  end

  def update
    user = User.find(params[:id])
    user.update!
  end

  private
  def user_params
    params.require(:user).permit(:email, :gender, :preferred_time,
    :weather_perception, :avatar)
  end
end
