class Post < ApplicationRecord
  belongs_to :user

  def user
    User.find_by(id: user_id)
  end
end
