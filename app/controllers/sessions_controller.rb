# coding: utf-8

class SessionsController < ApplicationController
  def new
    @title = "Zaloguj sie"
    unless current_user.nil? 
      redirect_to root_path
    end
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Nieprawidłowa kombinacja email/hasło"
      @title = "Zaloguj sie"
      render 'new'
    else
      sign_in user            
      flash[:success] = "Zalogowano, witaj w serwisie #{current_user.name}."
      redirect_to root_path
    end
  end
  
  def destroy
      sign_out   
      flash[:notice] = "Wylogowano z Jetu"
      redirect_to root_path
  end

end
