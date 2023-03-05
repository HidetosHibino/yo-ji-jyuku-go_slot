module Sampleable
  extend ActiveSupport::Concern

  included do
    has_many :samples, as: :sampleable
  end
end
