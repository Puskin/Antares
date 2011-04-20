class UsersController < ApplicationController
  def new
    @title = "Zarejestruj sie"
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title = "#{@user.name} #{@user.surname}"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to roo_path
      flash[:success] = "Zarejestrowany! Witaj w Jetu #{@user.name}!"
    else
      @title = "Zarejestruj sie"
      render 'new'
    end
  end

end
