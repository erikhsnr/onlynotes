class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :fach

  validates :user_id, presence: true
  validates :fach_id, presence: true

  def self.followed?(user, fach)
    Follow.where(user_id: user.id, fach_id: fach.id).exists?
  end
end
