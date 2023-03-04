class Kanji < ApplicationRecord
  VALID_LETTER_REGEX = /\p{Han}/.freeze
  RANDOM_REF_YOJI_LENGTH = 4

  validates :letter, presence: true, length: { maximum: 1 }
  validates :letter, format: { with: VALID_LETTER_REGEX, message: :not_kanji_letter }

  # basic_yoji に対するリレーション
  has_many :basic_first_kanjis, class_name: 'BasicYoji', foreign_key: 'first_kanji_id', dependent: :destroy
  has_many :basic_second_kanjis, class_name: 'BasicYoji', foreign_key: 'second_kanji_id', dependent: :destroy
  has_many :basic_third_kanjis, class_name: 'BasicYoji', foreign_key: 'third_kanji_id', dependent: :destroy
  has_many :basic_fourth_kanjis, class_name: 'BasicYoji', foreign_key: 'fourth_kanji_id', dependent: :destroy

  # slot_yoji に対するリレーション
  has_many :slot_first_kanjis, class_name: 'SlotYoji', foreign_key: 'first_kanji_id', dependent: :destroy
  has_many :slot_second_kanjis, class_name: 'SlotYoji', foreign_key: 'second_kanji_id', dependent: :destroy
  has_many :slot_third_kanjis, class_name: 'SlotYoji', foreign_key: 'third_kanji_id', dependent: :destroy
  has_many :slot_fourth_kanjis, class_name: 'SlotYoji', foreign_key: 'fourth_kanji_id', dependent: :destroy

  # 一覧画面で四字熟語をランダムで出すようのメソッド
  def random_ref_yoji
    # slot_first_kanjis, slot_second_kanjis, slot_third_kanjis, slot_fourth_kanjis]
    yoji_ary = [basic_first_kanjis, basic_second_kanjis, basic_third_kanjis, basic_fourth_kanjis]
    yoji_ary.flatten!.uniq.sample(RANDOM_REF_YOJI_LENGTH)
  end
end
