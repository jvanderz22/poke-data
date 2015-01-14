class TeamSessionController < ApplicationController
  def show
    if user_signed_in?
      render json: { user_team_id: session[:user_team_id] }.to_json
    else
      render json: { user_team_id: nil }.to_json
    end
  end
end
