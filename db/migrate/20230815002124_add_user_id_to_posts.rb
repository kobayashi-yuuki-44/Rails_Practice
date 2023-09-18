class AddUserIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :user, foreign_key: true, null: false
  end
end
