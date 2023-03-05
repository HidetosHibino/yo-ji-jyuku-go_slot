class BasicYojis::SamplesController < SamplesController
  private

  def set_sampleable
    @sampleable = BasicYoji.find(params[:basic_yoji_id])
  end
end
