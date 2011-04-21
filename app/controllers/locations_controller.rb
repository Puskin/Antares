class LocationsController < ApplicationController
  before_filter :authenticate, :only => [:show, :create, :destroy]
  
  
  
  def create
    @location = current_user.locations.build(params[:location])
    if @location.save
      flash[:success] = "Dodales lokalizacje"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end
  
  def destroy
  end
  
end