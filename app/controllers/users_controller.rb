class UsersController < ApplicationController
  before_filter :authenticate,      :only => [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user,      :only => [:edit, :update]
  before_filter :admin_user,        :only => :destroy   
  before_filter :connection_exists, :only => :show
  
  def new
    @title = "Zarejestruj sie"
    @user = User.new
  end
  
  def index                                              
    @contacts = current_user.contacts
    @pending_contacts = current_user.pending_contacts
    @requested_contacts = current_user.requested_contacts
    @users = User.all
    @title = "Wszyscy uzytkownicy"
  end
  
  def show
    @user = User.find(params[:id])
    @locations = @user.locations.find(:all)
    @latest_location = @user.locations.find(:first)
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
    
      def connection_exists
        @user = current_user
        @contact = User.find(params[:id])
        @connection = Connection.connected?(@user, @contact)
        unless @connection == true or current_user?(@contact)
          flash[:error] = "Nie jestescie znajomymi"
          redirect_to users_path
        end            
      end
        
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
      end
      
      def admin_user
        redirect_to(root_path) unless current_user.admin?
      end

end
