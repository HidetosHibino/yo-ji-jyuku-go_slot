class SlotYojisController < ApplicationController
  before_action :set_users_slot_yoji, only: %i[edit update destroy]

  def index
    @slot_yojis = SlotYoji.all.order(created_at: :desc).page(params[:page])
  end

  def new
    @slot_yoji = SlotYoji.new
    @json_kanjis = Kanji.select(:id, :letter).all.sample(100).to_json
  end

  def confirm
    @slot_yoji = SlotYoji.new(confirm_params)
    logger.debug(@slot_yoji)
  end

  def create
    @slot_yoji = current_user.slot_yojis.build(slot_yoji_params)
    logger.debug(@slot_yoji.inspect)
    if @slot_yoji.save
      msg = []
      msg << t('defaults.message.created', item: SlotYoji.model_name.human)
      msg << "<a class=\"suggest_twitter\" onclick=\"tweetResult()\" data-tweetst=#{@slot_yoji.decorate.jyukugo_mode}>twitter</a>で結果をシェアする"
      redirect_to slot_yoji_path(@slot_yoji), success: msg.join("<br />").html_safe
    else
      flash.now[:danger] = t('defaults.message.not_created', item: SlotYoji.model_name.human)
      render :confirm
    end
  end

  def show
    @slot_yoji = SlotYoji.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).find(params[:id])
    @related_kanji = RelatedKanji.new(@slot_yoji)
  end

  def edit; end

  def update
    if @slot_yoji.update(update_params)
      redirect_to slot_yoji_path(@slot_yoji), success: t('defaults.message.updated', item: SlotYoji.model_name.human)
    else
      flash.now[:danger] = t('default.message.not_updated', item: SlotYoji.model_name.human)
      render :edit
    end
  end

  def destroy
    @slot_yoji.destroy!
    redirect_to slot_yojis_path, success: t('defaults.message.deleted', item: SlotYoji.model_name.human)
  end

  private

  def set_users_slot_yoji
    @slot_yoji = current_user.slot_yojis.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).find(params[:id])
  end

  def confirm_params
    params.require(:slot_yoji).permit(:first_kanji_id, :second_kanji_id, :third_kanji_id, :fourth_kanji_id)
  end

  def slot_yoji_params
    params.require(:slot_yoji).permit(:first_kanji_id, :second_kanji_id, :third_kanji_id, :fourth_kanji_id, :sound, :meaning)
  end

  def update_params
    params.require(:slot_yoji).permit(:sound,:meaning)
  end
end
