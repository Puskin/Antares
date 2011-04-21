class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def new
    @title = "Zarejestruj sie"
    @user = User.new
  end
  
  def index
    @users = User.all
    @title = "Wszyscy uzytkownicy"
  end
  
  def show
    @user = User.find(params[:id])
    @locations = @user.locations.find(:all)
    @title = "#{@user.name} #{@user.surname}"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to root_path
      flash[:success] = "Zarejestrowany! Witaj w Jetu #{@user.name}!"
    else
      @title = "Zarejestruj sie"
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @title = "Edycja profilu #{@user.name} #{@user.surname}"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profil zaktualizowany!"
      redirect_to edit_user_path(@user)
    else
      @title = "Edycja uzytkownika"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Uzytkownik zniszczony!"
    redirect_to users_path
  end
  
    private
        
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
      end
      
      def admin_user
        redirect_to(root_path) unless current_user.admin?
      end

end
