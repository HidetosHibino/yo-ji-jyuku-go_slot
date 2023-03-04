class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :basic_yojis, dependent: :nullify
  has_many :slot_yojis, dependent: :destroy
  has_many :samples, dependent: :destroy

  has_many :user_reactions
  has_many :meanings, through: :user_reactions
  has_many :comments, through: :user_reactions

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def own?(object)
    id == object.user_id
  end
end
