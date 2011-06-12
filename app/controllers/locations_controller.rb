# coding: utf-8

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
      flash[:success] = "Dodano lokalizację"
      redirect_to root_path
    else
      flash.now[:error] = "Wystąpil problem, sprawdź dane i spróbuj ponownie"
      render 'new'
    end
  end
  
  def show     
    @location = Location.find(params[:id])  
    @title = @location.title   
  end
  
  def destroy
  end     
  
    private
    
    def users_connected 
      location = Location.find(params[:id])
      unless Connection.connected?(current_user, location.user) or current_user == location.user 
        flash[:error] = "Nie znasz osoby, ktora dodala ta lokacje"
        redirect_to users_path
      end
    end 
  
end