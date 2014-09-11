class HomeController < ApplicationController
  before_filter :ensure_user_signed_in

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end