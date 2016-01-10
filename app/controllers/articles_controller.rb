class ArticlesController < ApplicationController
  before_filter :require_login, except: [:index, :show]

  include ArticlesHelper
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    flash.notice = "Article '#{@article.title}' was Created!"
    redirect_to article_path(@article)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    flash.notice = "Article '#{@article.title}' Updated!"
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @taggings = Tagging.all
    @taggings.each do |tagging|
      if tagging.article_id == params[:id]
        Tagging.find(tagging.id).destroy
      end
    end
    @comments = Comment.all
    @comments.each do |comment|
      if comment.article_id == params[:id]
        Comment.find(comment.id).destroy
      end
    end
    @article.destroy
    flash.notice = "Article '#{@article.title}' Deleted!"
    redirect_to articles_path
  end
end
