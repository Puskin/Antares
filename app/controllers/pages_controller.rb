class PagesController < ApplicationController
  def home    
    if signed_in?
      @title = "Ostatnie zmiany w Twoim otoczeniu"
      @page_id = "map"
      @location = Location.new
      @contacts = current_user.contacts
    else
      @title = "Zarejestruj sie lub zaloguj i zacznij zabawe!" 
    end
  end

  def about
    @title = "Dlaczego pokochasz Jetu?"
  end

end
