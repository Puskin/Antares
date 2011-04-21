class PagesController < ApplicationController
  def home    
    if signed_in?
      @title = "Ostatnie zmiany w Twoim otoczeniu"
      @location = Location.new if signed_in?
      @feed_items = current_user.feed
    else
      @title = "Zarejestruj sie lub zaloguj i zacznij zabawe!" 
    end
  end

  def about
    @title = "Dlaczego pokochasz Jetu?"
  end

end
