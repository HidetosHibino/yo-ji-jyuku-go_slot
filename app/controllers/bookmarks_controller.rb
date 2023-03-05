class BookmarksController < ApplicationController
  before_action :valid_param?, :set_bookmarkable, only: %i[create destroy]
  def index
    @bookmarked_sloy_yojis = current_user.bookmarked_slot_yojis.includes(:user, :first_kanji, :second_kanji, :third_kanji, :fourth_kanji)
    @bookmarked_samples = current_user.bookmarked_samples.includes(:user, sampleable: [:first_kanji, :second_kanji, :third_kanji, :fourth_kanji])
    @bookmarked_comments = current_user.bookmarked_user_reactions.includes(:user, slot_yoji: [:first_kanji, :second_kanji, :third_kanji, :fourth_kanji]).where(type: 'Comment')
    @bookmarked_meanings = current_user.bookmarked_user_reactions.includes(:user, slot_yoji: [:first_kanji, :second_kanji, :third_kanji, :fourth_kanji]).where(type: 'Meaning')
  end

  def create
    current_user.bookmark(@bookmarkable)
  end

  def destroy
    current_user.unbookmark(@bookmarkable)
  end

  private

  def valid_param?
    redirect_back fallback_location: '/' unless Bookmark::BOOKMARKABLE_TYPES.include?(params[:type])
  end

  def set_bookmarkable
    @bookmarkable = params[:type].constantize.find(params[:id])
  end
end
