class KanjisController < ApplicationController
  def index
    @kanjis = Kanji.includes(%i[basic_first_kanjis basic_second_kanjis basic_third_kanjis basic_fourth_kanjis
                                slot_first_kanjis slot_second_kanjis slot_third_kanjis slot_fourth_kanjis]).all.page(params[:page])
  end

  def show
    @kanji = Kanji.find(params[:id])
    @slot_yojis = SlotYoji.used_with(@kanji).page(params[:slot_yojis_page])
    @basic_yojis = BasicYoji.used_with(@kanji).page(params[:basic_yojis_page])
    # pagenationはAjax化するため分岐
    respond_to do |format|
      format.html
      format.js
    end
  end
end
