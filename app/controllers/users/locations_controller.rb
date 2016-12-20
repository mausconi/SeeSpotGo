class LocationsController < ApplicationController
  def create
    @location = Location.create(location_params)
    redirect_to user_path(@location.user_id)
  end

  def reservation_params
    params.require(:location).permit(:street_address, :city, :state, :zip).merge(user_id: current_user.id)
  end
end
