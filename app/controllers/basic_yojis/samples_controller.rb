class BasicYojis::SamplesController < SamplesController
  before_action :set_sampleable

  private

  def set_sampleable
    @sampleable = BasicYoji.find(params[:basic_yoji_id])
  end
end
