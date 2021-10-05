class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  attachment :image
end
