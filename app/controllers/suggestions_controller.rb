class SuggestionsController < ApplicationController
  def create
    suggestion = Suggestion.create!(
      user_id: current_user.id,
      body: params[:body],
    )
    render json: suggestion.as_json
  end
end
