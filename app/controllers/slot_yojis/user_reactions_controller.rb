class SlotYojis::UserReactionsController < ApplicationController
  before_action :set_own_user_reactions, only: %i[update destroy]

  def create
    @user_reaction = params[:type].constantize.new(create_user_reactions_param)
    @user_reaction.user = current_user
    if @user_reaction.save
      redirect_to @user_reaction.slot_yoji, success: t('defaults.message.created', item: params[:type].constantize.model_name.human)
    else
      redirect_to @user_reaction.slot_yoji, danger: t('defaults.message.not_created', item: params[:type].constantize.model_name.human)
    end
  end

  def update
    if @user_reaction.update(update_user_reactions_param)
      redirect_to @user_reaction.slot_yoji, success: t('defaults.message.updated', item: @user_reaction.class.model_name.human)
    else
      redirect_to @user_reaction.slot_yoji, danger: t('defaults.message.not_updated', item: @user_reaction.class.model_name.human)
    end
  end

  def destroy
    @user_reaction.destroy!
    redirect_to @user_reaction.slot_yoji, success: t('defaults.message.deleted', item: @user_reaction.class.model_name.human)
  end

  private

  def create_user_reactions_param
    params.require(params[:type].underscore.to_sym).permit(:body).merge(slot_yoji_id: params[:slot_yoji_id])
  end

  def update_user_reactions_param
    params.require(params[:type].underscore.to_sym).permit(:body)
  end

  def set_own_user_reactions
    @user_reaction = current_user.user_reactions.find(params[:id])
  end
end
