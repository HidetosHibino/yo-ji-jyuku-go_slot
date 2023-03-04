class BasicYoji < ApplicationRecord
  MOJI_NUM_LENGTH = 4
  VALID_SOUND_CHAR = /\A[ぁ-んー－]+\z/.freeze

  include Sampleable
  # has_many :samples, as: :sampleable

  belongs_to :user

  belongs_to :first_kanji, class_name: 'Kanji', foreign_key: 'first_kanji_id'
  belongs_to :second_kanji, class_name: 'Kanji', foreign_key: 'second_kanji_id'
  belongs_to :third_kanji, class_name: 'Kanji', foreign_key: 'third_kanji_id'
  belongs_to :fourth_kanji, class_name: 'Kanji', foreign_key: 'fourth_kanji_id'

  validates :sound, format: { with: VALID_SOUND_CHAR, message: :not_sound_hiragana }, allow_blank: true
  validates :name, uniqueness: true
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

  # form_object にしたほうがいいかもしれない
  def save_with_kanjis(basic_yoji_param)
    return false unless check_params(basic_yoji_param)
    kanjis = basic_yoji_param[:name].chars
    meaning = basic_yoji_param[:meaning]
    sound = basic_yoji_param[:sound]
    ActiveRecord::Base.transaction do
      self.first_kanji = Kanji.find_or_create_by(letter: kanjis[0])
      self.second_kanji = Kanji.find_or_create_by(letter: kanjis[1])
      self.third_kanji = Kanji.find_or_create_by(letter: kanjis[2])
      self.fourth_kanji = Kanji.find_or_create_by(letter: kanjis[3])
      self.name = basic_yoji_param[:name]
      self.meaning = meaning
      self.sound = sound
      save!
    end
    true
  rescue StandardError => e
    logger.debug(e)
    false
  end

  def check_params(basic_yoji_param)
    return_flg = true

    logger.debug(basic_yoji_param[:name].length)
    unless basic_yoji_param[:name].length == 4
      errors.add(:base, '四字熟語は4文字で入力してください')
      return_flg = false
    end

    # Kanjiモデルのvalidationエラーを拾えないため、ここで実施
    basic_yoji_param[:name].chars.each do |kanji|
      unless kanji =~ Kanji::VALID_LETTER_REGEX
        errors.add(:base, '四字熟語は漢字のみで入力してください')
        return_flg = false
        break
      end
    end
    return_flg
  end
end
