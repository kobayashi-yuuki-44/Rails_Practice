class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:success] = "Login successful."
      redirect_back_or_to posts_path
    else
      flash.now[:danger] = "Login failed."
      render :new
    end
  end

  def destroy
    logout
    redirect_back_or_to login_path, notice: "Logout successful."
  end

  def user_show
    @user = @post.user
    @posts = @user.posts
 end

 private

  def set_post
  @post = Post.find_by(id: params[:id])
  end
end
