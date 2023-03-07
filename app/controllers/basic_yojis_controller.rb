class BasicYojisController < ApplicationController
  before_action :set_user_basic_yoji, only: %i[edit update destroy]
  skip_before_action :require_login, only: %i[index]

  def index
    @q = BasicYoji.ransack(params[:q])
    @basic_yojis = @q.result(distinct: true).includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji, :user).all.order(created_at: :desc).page(params[:page])
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
    @basic_yoji = BasicYoji.find(params[:id])
    @related_kanji = RelatedKanji.new(@basic_yoji)
    @samples = @basic_yoji.samples.order(created_at: :desc).page(params[:page]).per(8)
  end

  def edit; end

  def update
    if @basic_yoji.save_with_kanjis(basic_yoji_params)
      redirect_to basic_yoji_path(@basic_yoji), success: t('defaults.message.updated', item: BasicYoji.model_name.human)
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

  def set_user_basic_yoji
    @basic_yoji = current_user.basic_yojis.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji).find(params[:id])
  end
end
