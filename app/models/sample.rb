class Sample < ApplicationRecord
  include Bookmarkable

  SAMPLE_HEADER_NEED = %w[profiles bookmarks].freeze

  belongs_to :sampleable, polymorphic: true
  belongs_to :user

  validates :body, presence: true
end
