class V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users
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
