class HomeController < ApplicationController
  before_filter :ensure_user_signed_in

  def index
    @user = current_user
  end
end