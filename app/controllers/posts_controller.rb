class PostsController < ApplicationController
  before_action :redirect_guest, only: [:new,:create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post successfully submitted."
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def index
    @posts = Post.all
  end

  private

    def post_params
      params.require(:post).permit(:body, :user_id)
    end

    def redirect_guest
      redirect_to sign_in_path unless logged_in?
    end
end
