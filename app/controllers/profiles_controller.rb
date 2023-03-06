class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :ensure_current_user, only: %i[edit update]
  def show
    @user = User.select(:id, :name, :avatar, :introduction).find(params[:id])
    @slot_yojis = @user.slot_yojis.includes(:first_kanji, :second_kanji, :third_kanji, :fourth_kanji, :user, bookmarks: :user).order(created_at: :desc).limit(8)
    @meanings = @user.user_reactions.where(type: :Meaning).includes(:slot_yoji, bookmarks: :user).order(created_at: :desc).limit(8)
    @samples = @user.samples.includes(sampleable: [:first_kanji, :second_kanji, :third_kanji, :fourth_kanji, :user ]).order(created_at: :desc).limit(8)
  end

  def edit; end

  def update
    if @user.update(profile_params)
      redirect_to profile_path(@user), success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now['danger'] = t('.dedaults.message.not_updated', item: User.model_name.human)
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def ensure_current_user
    begin
      unless Integer(params[:id]) == current_user.id
        redirect_to edit_profile_path(current_user)
      end
    rescue ArgumentError
      raise ActiveRecord::RecordNotFound
    end
    @user = User.find(current_user.id)
  end

  def profile_params
    params.require(:user).permit(:name, :introduction, :avatar, :avatar_cache)
  end
end
