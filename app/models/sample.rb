class Sample < ApplicationRecord
  include Bookmarkable

  belongs_to :sampleable, polymorphic: true
  belongs_to :user

  validates :body, presence: true
end
