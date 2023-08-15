class Post < ApplicationRecord
  belongs_to :user

  def user
    return User.find_by(id: self.user_id)
  end

end
