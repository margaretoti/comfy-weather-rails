class V1::ArticleOfClothingsController < ApplicationController
  def index
    articles = ArticleOfClothing.all

    render json: articles
  end

  def create
    article = ArticleOfClothing.create!(article_of_clothing_params)

    render json: article
  end

  # private
  # def article_of_clothing_params
  #   params.require(:article_of_clothing).permit(:description, :category)#.merge(user: current_user)
  # end
end
