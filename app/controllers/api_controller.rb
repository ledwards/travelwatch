class ApiController < ApplicationController
  acts_as_token_authentication_handler_for User

  def trips
    @user = current_user
    render json: @user.trips.to_json
  end
end
