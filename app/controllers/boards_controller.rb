class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)#下記で説明
    if @board.save
      redirect_to boards_path, success: t('defaults.message.created', item: Board.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Board.model_name.human)
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to @board, success: t('defaults.message.updated', item: Board.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Board.model_name.human)
      render :edit
    end
  end

  def destroy
    @board = current_user.boards.find(params[:id])
    @board.destroy!
    redirect_to boards_path, success: t('defaults.message.deleted', item: Board.model_name.human)
  end

  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :bord_image_cache)
  end
end
