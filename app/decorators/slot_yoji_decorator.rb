class SlotYojiDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def jyukugo_mode
    "#{object.first_kanji.letter}&thinsp;#{object.second_kanji.letter}&thinsp;#{object.third_kanji.letter}&thinsp;#{object.fourth_kanji.letter}".html_safe
  end
end
