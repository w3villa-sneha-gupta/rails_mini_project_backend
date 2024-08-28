class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user  
    @user_subscription = current_user.subscriptions.last
  end

end
