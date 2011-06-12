# coding: utf-8

class PagesController < ApplicationController  
  
  before_filter :authenticate, :except => [:home, :about]
  
  def home    
    if signed_in?
      @title = "Ostatnie zmiany w Twoim otoczeniu"
      @page_id = "map"
      @actuall_location = current_user.locations.first
    else
      @page_id = "landing"
      @title = "Zarejestruj się lub zaloguj i zacznij zabawę!" 
    end
  end   
  
  def feed
     @title = "Aktualności dla statusów Twoich znajomych"     
     @events = User.feed(current_user)
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
