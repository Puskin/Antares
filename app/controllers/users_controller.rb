class UsersController < ApplicationController
  def new
    @title = "Zarejestruj sie"
  end
  
  def show
    @user = User.find(params[:id])
    @title = "#{@user.name} #{@user.surname}"
  end

end
