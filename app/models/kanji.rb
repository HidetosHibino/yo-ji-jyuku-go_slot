class Kanji < ApplicationRecord
  VALID_LETTER_REGEX = /\p{Han}/.freeze

  validates :letter, presence: true, length: { maximum: 1 }
  validates :letter, format: { with: VALID_LETTER_REGEX, message: :not_kanji_letter }

  # basic_yoji に対するリレーション
  has_many :basic_first_kanji, class_name: 'basic_yoji', foreign_key: 'first_kanji_id', dependent: :destroy
  has_many :basic_second_kanji, class_name: 'basic_yoji', foreign_key: 'second_kanji_id', dependent: :destroy
  has_many :basic_third_kanji, class_name: 'basic_yoji', foreign_key: 'third_kanji_id', dependent: :destroy
  has_many :basic_fourth_kanji, class_name: 'basic_yoji', foreign_key: 'fourth_kanji_id', dependent: :destroy

  # slot_yoji に対するリレーション
  has_many :slot_first_kanji, class_name: 'slot_yoji', foreign_key: 'first_kanji_id', dependent: :destroy
  has_many :slot_second_kanji, class_name: 'slot_yoji', foreign_key: 'second_kanji_id', dependent: :destroy
  has_many :slot_third_kanji, class_name: 'slot_yoji', foreign_key: 'third_kanji_id', dependent: :destroy
  has_many :slot_fourth_kanji, class_name: 'slot_yoji', foreign_key: 'fourth_kanji_id', dependent: :destroy
end
