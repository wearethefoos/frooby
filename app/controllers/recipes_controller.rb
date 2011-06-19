class RecipesController < ApplicationController

  before_filter :login_required, :except => [:index, :show]
  
  def new
    @recipe = Recipe.new
  end

  def index
    @page    = (params[:page] || 1).to_i
    @recipes = Recipe.paginate(:page => @page, :per_page => 15)
  end

  def show
    @recipe    = Recipe.find_by_slug(params[:id])
    @comments  = Comment.threaded_with_field(@recipe)
  end

  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user = current_user
    if @recipe.save
      redirect_to root_url
    else
      render :action => :new
    end
  end

  # Uses the class method of upvote to fire and forget.
  def upvote
    recipe_id = Mongo::ObjectID.from_string(params[:id])
    Recipe.upvote(recipe_id, current_user.id)
    render :nothing => true
  end
end