class PagesController < ApplicationController  
  
  before_filter :authenticate, :except => [:home, :about]
  
  def home    
    if signed_in?
      @title = "Ostatnie zmiany w Twoim otoczeniu"
      @page_id = "map"
      @actuall_location = current_user.locations.first
    else
      @title = "Zarejestruj sie lub zaloguj i zacznij zabawe!" 
    end
  end   
  
  def feed
     @contacts = current_user.contacts
      respond_to do |format|                   
          format.html
          format.xml
      end
  end 

  def about
    @title = "Dlaczego pokochasz Jetu?"
  end

end
