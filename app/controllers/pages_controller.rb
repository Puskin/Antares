class PagesController < ApplicationController
  def home
    @user = current_user
    if signed_in?
      @title = "Ostatnie zmiany w Twoim otoczeniu"
    else
      @title = "Zarejestruj sie lub zaloguj i zacznij zabawe!" 
    end
  end

  def about
    @title = "Dlaczego pokochasz Jetu?"
  end

end
