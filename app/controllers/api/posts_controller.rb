class Api::PostsController < ApplicationController
include Api::PostsHelper

  before_action :current_api_user!

  def index
    render json: @current_user.posts
  end

  def show
    render json: @current_user.posts.find(params[:id])
  end

  def create
    post = @current_user.posts.create(post_params)
    respond_to do |format|
      if post.save
        format.html{head :no_content}
        format.json{head :no_content}
      else
        format.html{render :status => 401}
        format.json{render :status => 401}
      end
    end
  end

  def destroy
    @current_user.posts.destroy(params[:id])
    render status: 202
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

end