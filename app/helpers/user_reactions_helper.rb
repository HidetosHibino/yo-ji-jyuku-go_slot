module UserReactionsHelper
  def user_reaction_header_need?
    UserReaction::USER_REACTION_HEADER_NEED.include?(controller_path)
  end
end
