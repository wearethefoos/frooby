class CommentsController < ApplicationController
  before_filter :login_required, :except => :index
  skip_before_filter :verify_authenticity_token

  def index
    @comments = Comment.find
  end

  def create
    @recipe   = Recipe.find(params[:comment][:recipe_id])
    @comment = Comment.new(params[:comment].merge(:user => current_user))
    @comment.save
    redirect_to recipe_url(@recipe)
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote(current_user)
    render :nothing => true
  end
end