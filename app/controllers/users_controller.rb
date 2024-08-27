class UsersController < ApplicationController
    before_action :authenticate_user!  # Ensure user is authenticated
    before_action :set_user, only: [:edit, :update]
  
    def edit
      # Action to render the edit form
    end
  
    def update
      if @user.update(user_params)
        geocode_address(@user) if @user.address_changed?
        redirect_to dashboard_path, notice: 'Address updated successfully.'
      else
        render :edit
      end
    end
  
    private
  
    def set_user
      @user = current_user  # Fetch the current user
    end
  
    def user_params
      params.require(:user).permit(:address)
    end
  
    def geocode_address(user)
      result = GeocodingService.new(ENV['OPENCAGE_API_KEY']).geocode_address(user.address)
      if result[:error].nil?
        user.update(latitude: result[:latitude], longitude: result[:longitude], formatted_address: result[:formatted_address])
      else
        flash[:alert] = result[:error]
      end
    end
end
  