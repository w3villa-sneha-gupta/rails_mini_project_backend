class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    # Dashboard logic goes here
  end
end
