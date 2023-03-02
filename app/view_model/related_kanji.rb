class RelatedKanji
  attr_reader :first_kanji, :second_kanji, :third_kanji, :fourth_kanji,
              :basic_with_first_kanjis, :basic_with_second_kanjis, :basic_with_third_kanjis, :basic_with_fourth_kanjis,
              :slot_with_first_kanjis, :slot_with_second_kanjis, :slot_with_third_kanjis, :slot_with_fourth_kanjis

  # controller で実装して、継承でもよかったかも。。。
  def initialize(yoji_obj)
    @first_kanji = yoji_obj.first_kanji
    @second_kanji = yoji_obj.second_kanji
    @third_kanji = yoji_obj.third_kanji
    @fourth_kanji = yoji_obj.fourth_kanji

    @basic_with_first_kanjis = BasicYoji.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).used_with(yoji_obj.first_kanji).sample(4)
    @basic_with_second_kanjis = BasicYoji.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).used_with(yoji_obj.second_kanji).sample(4)
    @basic_with_third_kanjis = BasicYoji.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).used_with(yoji_obj.third_kanji).sample(4)
    @basic_with_fourth_kanjis = BasicYoji.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).used_with(yoji_obj.fourth_kanji).sample(4)
    @slot_with_first_kanjis = SlotYoji.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).used_with(yoji_obj.first_kanji).sample(4)
    @slot_with_second_kanjis = SlotYoji.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).used_with(yoji_obj.second_kanji).sample(4)
    @slot_with_third_kanjis = SlotYoji.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).used_with(yoji_obj.third_kanji).sample(4)
    @slot_with_fourth_kanjis = SlotYoji.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).used_with(yoji_obj.fourth_kanji).sample(4)
  end
end
