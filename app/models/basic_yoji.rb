class BasicYoji < ApplicationRecord
  MOJI_NUM_LENGTH = 4
  VALID_SOUND_CHAR = /\A[ぁ-んー－]+\z/.freeze
  VALID_NAME_STRING = /\p{Han}{4}/.freeze

  include Sampleable
  # has_many :samples, as: :sampleable

  belongs_to :user

  belongs_to :first_kanji, class_name: 'Kanji', foreign_key: 'first_kanji_id'
  belongs_to :second_kanji, class_name: 'Kanji', foreign_key: 'second_kanji_id'
  belongs_to :third_kanji, class_name: 'Kanji', foreign_key: 'third_kanji_id'
  belongs_to :fourth_kanji, class_name: 'Kanji', foreign_key: 'fourth_kanji_id'

  validates :sound, format: { with: VALID_SOUND_CHAR, message: :not_sound_hiragana }, allow_blank: true
  validates :name, uniqueness: true, length: { is: MOJI_NUM_LENGTH }
  # うまくいかないので、nameカラムを追加
  # 弾けるが、First_kanjiがすでに存在します。　になるため
  # validates :first_kanji_id, uniqueness: {
  #   scope: [:second_kanji_id, :third_kanji_id, :fourth_kanji_id],
  #   message: "すでに存在します。"
  # }

  scope :used_with, lambda { |args_kanji|
    result = where(first_kanji: args_kanji).or(where(second_kanji: args_kanji)).or(where(third_kanji: args_kanji)).or(where(fourth_kanji: args_kanji))
    merge(result)
    # 結果を他のスコープ結果にmergeする感じ
  }
end
