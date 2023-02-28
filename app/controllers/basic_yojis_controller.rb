class BasicYojisController < ApplicationController
  before_action :set_basic_yoji, only: %i[show edit update destroy]

  def index
    @basic_yojis = BasicYoji.all.order(created_at: :desc).page(params[:page])
  end

  def new
    @basic_yoji = BasicYoji.new
  end

  def create
    @basic_yoji = current_user.basic_yojis.new(basic_yoji_params)
    if @basic_yoji.save_with_kanjis(basic_yoji_params)
      redirect_to basic_yoji_path(@basic_yoji), success: t('defaults.message.created', item: BasicYoji.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: BasicYoji.model_name.human)
      render :new
    end
  end

  def show
    @basic_with_first_kanji = BasicYoji.used_with(@basic_yoji.first_kanji).limit(4)
    @basic_with_second_kanji = BasicYoji.used_with(@basic_yoji.second_kanji).limit(4)
    @basic_with_third_kanji = BasicYoji.used_with(@basic_yoji.third_kanji).limit(4)
    @basic_with_fourth_kanji = BasicYoji.used_with(@basic_yoji.fourth_kanji).limit(4)
  end

  def edit; end

  def update
    if @basic_yoji.save_with_kanji(basic_yoji_params)
      redirect_to basic_yoji_path(@basic_yoji), success: t('defaults.message.updated', item: Basic_yoji.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: BasicYoji.model_name.human)
    end
  end

  def destroy
    @basic_yoji.destroy!
    redirect_to basic_yojis_path, success: t('defaults.message.deleted', item: BasicYoji.model_name.human)
  end

  private

  def basic_yoji_params
    params.require(:basic_yoji).permit(:name, :sound, :meaning)
  end

  def set_basic_yoji
    @basic_yoji = BasicYoji.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).find(params[:id])
  end
end
