class UserReaction < ApplicationRecord
  # STI class as parent
  belongs_to :slot_yoji
  belongs_to :user

  has_many :meanings
  has_many :comments

  validates :body, presence: true
end
