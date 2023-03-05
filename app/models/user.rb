class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :bookmarks, dependent: :destroy

  has_many :basic_yojis, dependent: :nullify
  has_many :slot_yojis, dependent: :destroy
  # あくまでUserModelから見るとbookmarkable　が対象の関連性であり、 それ(bookmarkable)のsource_type が'SlotYoji'ということ
  has_many :bookmarked_slot_yojis, through: :bookmarks, source: :bookmarkable, source_type: 'SlotYoji'

  has_many :samples, dependent: :destroy
  has_many :bookmarked_samples, through: :bookmarks, source: :bookmarkable, source_type: 'Sample'

  has_many :user_reactions
  has_many :bookmarked_user_reactions, through: :bookmarks, source: :bookmarkable, source_type: 'UserReaction'
  has_many :meanings, through: :user_reactions
  # 機能しないのでコメントアウト(bookmarkの bookmarkable_type = UserRectionになるので)
  # やるならメソッド化して、 bookmarked_user_reaction から引っ張ってくる
  # has_many :bookmarked_meanings, through: :bookmarks, source: :bookmarkable, source_type: 'Meaning'
  has_many :comments, through: :user_reactions
  # has_many :bookmarked_comments, through: :bookmarks, source: :bookmarkable, source_type: 'Comment'

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def own?(object)
    id == object.user_id
  end

  def bookmark?(bookmarkable)
    bookmarkable.bookmarks.pluck(:user_id).include?(id)
  end

  # bookmrks は bookmark の集合なので
  def bookmark(bookmarkable)
    bookmark = Bookmark.new(bookmarkable: bookmarkable)
    bookmarks << bookmark
  end

  def unbookmark(bookmarkable)
    bookmark = bookmarks.where(bookmarkable: bookmarkable)
    bookmarks.destroy(bookmark)
  end
end
