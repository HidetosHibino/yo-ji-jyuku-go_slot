class Bookmark < ApplicationRecord
  BOOKMARKABLE_TYPES = %w[Comment Meaning Sample SlotYoji].map(&:freeze).freeze

  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  validates :user_id, uniqueness: {
    scope: [:bookmarkable_id, :bookmarkable_type],
    # message: 'can only favorite an item once'
  }
end
