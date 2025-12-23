class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true

  def self.liked?(user, post)
    Like.where(user_id: user.id, post_id: post.id).exists?
  end
end
