class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  counter_culture :book
end
