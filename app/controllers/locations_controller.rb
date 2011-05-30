class LocationsController < ApplicationController
  before_filter :authenticate,      :only => [:show, :new, :create, :destroy]      
  before_filter :users_connected,   :only => :show                    
                
  
  def new
    @location = Location.new             
    @title = "Dodaj swoja lokalizacje"
  end
  
  def create
    @location = current_user.locations.build(params[:location])
    if @location.save
      flash[:success] = "Dodales lokalizacje"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end
  
  def show
    @location = Location.find(params[:id])
  end
  
  def destroy
  end     
  
    private
    
    def users_connected 
      location = Location.find(params[:id])
      unless Connection.connected?(current_user, location.user)
        flash[:error] = "Nie znasz osoby, ktora dodala ta lokacje"
        redirect_to users_path
      end
    end 
  
end