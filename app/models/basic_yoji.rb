class BasicYoji < ApplicationRecord
  belongs_to :user

  has_many :first_kanji, class_name: 'Kanji', foreign_key: 'first_kanji_id'
  has_many :second_kanji, class_name: 'Kanji', foreign_key: 'second_kanji_id'
  has_many :third_kanji, class_name: 'Kanji', foreign_key: 'third_kanji_id'
  has_many :fourth_kanji, class_name: 'Kanji', foreign_key: 'fourth_kanji_id'

  def save_with_kanji(submit_yoji)
    kanjis = submit_yoji.cahrs
    ActiveRecord::Base.transaction do
      self.first_kanji = Kanji.find_or_initialize_by(letter: kanjis[0])
      self.second_kanji = Kanji.find_or_initialize_by(letter: kanjis[1])
      self.third_kanji = Kanji.find_or_initialize_by(letter: kanjis[2])
      self.fourth_kanji = Kanji.find_or_initialize_by(letter: kanjis[3])
      save!
    end
    true
  rescue StandardError
    false
  end
end
