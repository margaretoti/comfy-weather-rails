class V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def update
    user = User.find(params[:id])
    user.update_attribute(:avatar, params[:user][:avatar])
end
