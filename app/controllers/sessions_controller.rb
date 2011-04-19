class SessionsController < ApplicationController
  def new
    @title = "Zaloguj sie"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Nieprawidlowa kombinacja email/haslo"
      @title = "Zaloguj sie"
      render 'new'
    else
      sign_in user
      redirect_to user
    end
  end
  
  def destroy
      sign_out
      redirect_to root_path
  end

end
