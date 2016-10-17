class V1::ArticleOfClothingsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    articles = ArticleOfClothing.where(category: @category)

    render json: articles
  end

  def create
    article = ArticleOfClothing.create!(article_of_clothing_params)

    render json: article
  end

  private

  def article_of_clothing_params
    params
      .require(:article_of_clothing)
      .permit(:description, :category_id)
      .merge(user: current_user)
  end
end
