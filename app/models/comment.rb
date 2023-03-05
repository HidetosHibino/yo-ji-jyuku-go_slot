class Comment < UserReaction
  # STI - class as child
  include Bookmarkable
end
