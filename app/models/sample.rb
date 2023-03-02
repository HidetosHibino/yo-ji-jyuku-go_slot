class Sample < ApplicationRecord
  belongs_to :sampleable, polymorphic: true
  belongs_to :user

  validates :body, presence: true
end
