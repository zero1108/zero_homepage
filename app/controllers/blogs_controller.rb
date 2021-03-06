class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :base_data

  # GET /blogs
  # GET /blogs.json
  def index
    if params[:category_id].present?
      @blogs = Blog.submitted.where(category_id: params[:category_id]).page(params[:page])
    else
      @blogs = Blog.submitted.order(id: :desc).page params[:page]
    end
    # render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def base_data
      @categories = Category.all
      @oauth_url = GithubApi.get_oauth_authorize_url(request.url)
      Rails.logger.info @oauth_url
    end
end
