class PagesController < ApplicationController
  def home
    @title = "Zarejestruj sie lub zaloguj i zacznij zabawe!" 
  end

  def about
    @title = "Dlaczego pokochasz Jetu?"
  end

end
