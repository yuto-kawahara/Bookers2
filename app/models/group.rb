class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users

  attachment :image
  validates :name, presence: true
  validates :introduction, presence: true
  def joined_by?(user)
    group_users.where(user_id: user.id).exists?
  end
end
