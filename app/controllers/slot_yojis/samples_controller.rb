class SlotYojis::SamplesController < SamplesController
  private

  def set_sampleable
    @sampleable = SlotYoji.find(params[:slot_yoji_id])
  end
end
