class SlotYoji < ApplicationRecord
  belongs_to :user

  belongs_to :first_kanji, class_name: 'Kanji', foreign_key: 'first_kanji_id'
  belongs_to :second_kanji, class_name: 'Kanji', foreign_key: 'second_kanji_id'
  belongs_to :third_kanji, class_name: 'Kanji', foreign_key: 'third_kanji_id'
  belongs_to :fourth_kanji, class_name: 'Kanji', foreign_key: 'fourth_kanji_id'
end
