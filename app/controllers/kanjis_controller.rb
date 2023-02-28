class KanjisController < ApplicationController
  def index
    @kanjis = Kanji.all.page(params[:page])
    # TODO: 2件ぐらい使用例を出したい。。。
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
