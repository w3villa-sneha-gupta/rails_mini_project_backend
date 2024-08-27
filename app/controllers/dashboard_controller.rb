class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user  # Retrieve the current user
  end
end
