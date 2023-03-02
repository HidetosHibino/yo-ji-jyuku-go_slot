class SlotYojis::SamplesController < SamplesController
  before_action :set_sampleable

  private

  def set_sampleable
    @sampleable = SlotYoji.find(params[:slot_yoji_id])
  end
end
