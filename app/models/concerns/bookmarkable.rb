module Bookmarkable
  extend ActiveSupport::Concern

  included do
    has_many :bookmarks, as: :bookmarkable
  end
end
