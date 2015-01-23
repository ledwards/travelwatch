class ApiController < ApplicationController
  def trips
    @user = User.find(params[:user_id])
    render json: @user.trips.to_json
  end
end
