class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :ensure_correct_user, only: [:edit]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to posts_path
    end
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, success: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, success: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, success: 'Post was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:title, :content)
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    return if @post.user == current_user

    redirect_to("/posts/index")
  end
end
