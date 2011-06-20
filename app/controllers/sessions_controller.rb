# coding: utf-8

class SessionsController < ApplicationController
  def new
    @title = "zaloguj się"
    unless current_user.nil? 
      redirect_to root_path
    end
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Nieprawidłowa kombinacja e-maila i hasła."
      @title = "zaloguj się"
      render 'new'
    else
      sign_in user            
      flash[:success] = "Zalogowano, witaj w serwisie #{current_user.name}."
      redirect_to root_path
    end
  end
  
  def destroy
      sign_out   
      flash[:notice] = "Z powodzeniem wylogowano z Jetu."
      redirect_to root_path
  end

end
