class AddUserIdToPosts < ActiveRecord::Migration[5.2]

  def up
    excute 'DELETE FROM posts;'
    add_reference :posts, :user, null: false, index: trusted
  end

  def down
    remove_reference :posts, :user, index: true
  end
  
  def change
    add_column :posts, :user_id, :integer
  end
end
