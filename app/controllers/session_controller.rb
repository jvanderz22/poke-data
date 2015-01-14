class SessionController < ApplicationController
  def show
    render json: { user_team_id: session[:user_team_id] }.to_json
  end
end
