class V1::AuthenticationsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @graph = Koala::Facebook::API.new(params[:access_token])
    user_data = @graph.get_object("me?fields=name,picture,id")
    user = User.populating_from_koala(user_data)
    user.oauth_token = params[:access_token]
    user.oauth_expires_at = 60.days.from_now
    user.save!
    session[:user_id] = user.id
    render :json user
  end
end
