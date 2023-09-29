class AddBoardImageToBoards < ActiveRecord::Migration[5.2]
  def change
    add_column :boards, :board_image, :string
  end
end
