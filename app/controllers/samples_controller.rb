class SamplesController < ApplicationController
  before_action :set_sampleable
  
  def create
    @sample = @sampleable.samples.new(sample_params)
    @sample.user = current_user
    if @sample.save
      redirect_to @sampleable, success: t('defaults.message.created', item: Sample.model_name.human)
    else
      # flash.now[:danger] = t('.not_created', item: Sample.model_name.human)
      # render で sampletable/ sampletable_id を指定する方法がわからないため、暫定的にこれ
      # false時には render_page_when_faild 的なメソッドを用意して、小クラスでオーバライドし、そこでパスをかく？
      redirect_to @sampleable, danger: t('defaults.message.not_created', item: Sample.model_name.human)
    end
  end

  def update
    @sample = current_user.samples.find(params[:id])
    if @sample.update(sample_params)
      redirect_to @sample.sampleable, success: t('defaults.message.updated', item: Sample.model_name.human)
    else
      redirect_to @sample.sampleable, danger: t('defaults.message.not_updated', item: Sample.model_name.human)
    end
  end

  def destroy
    @sample = current_user.samples.find(params[:id])
    @sample.destroy!
    redirect_to @sample.sampleable, success: t('defaults.message.deleted', item: Sample.model_name.human)
  end

  private

  def sample_params
    params.require(:sample).permit(:body)
  end

  def set_sampleable
    raise NotImplementedError
  end
end
