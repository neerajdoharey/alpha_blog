class ArticlesController < ApplicationController
  before_action :set_article, except: [:index, :new, :create]
  before_action :required_user, except: [:index, :show]
  before_action :required_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was Successfully created..."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was Successfully Deleted..."
    redirect_to articles_path
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was Successfully updated..."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  private

  def article_params
    params.require(:article).permit(:title,:description)
  end
  def set_article
    @article = Article.find(params[:id])
  end
  def required_same_user
    if current_user != @article.user
      flash[:danger] = "You are not authorized"
      redirect_to root_path
    end
  end
end
