class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: @articles
  end

  def search
    @articles = Article.where('lower(title) LIKE ?', "%#{params[:query].downcase}%")
    render json: @articles
  end
end
