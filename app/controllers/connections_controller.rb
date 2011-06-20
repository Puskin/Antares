# coding: utf-8

class ConnectionsController < ApplicationController       
  
  before_filter :authenticate
  before_filter :authorize_user, :only => [:edit, :update, :destroy]
 
  def edit
    @contact = @connection.contact
  end
  
  def create
    @contact = User.find(params[:user_id])
    respond_to do |format|
       if Connection.request(current_user, @contact)
         flash[:success] = "Wysłano zaproszenie."
         format.html { redirect_to users_path }
       else
         flash[:error] = "Nieprawidłowe połączenie."
         format.html { redirect_to users_path }
       end
    end
  end    
  
  def update
    respond_to do |format|
      contact = @connection.contact
      name = contact.name        
      case params[:commit]
      when "Akceptuje"
        @connection.accept
        flash[:success] = "Zaakceptowano połączenie."
      when "Odrzucam"
        @connection.breakup
        flash[:notice] = "Odrzucono połączenie z #{name}."
      when "Cofnij"
        @connection.breakup
        flash[:notice] = "Anulowano zaproszenie."
      when "Anuluj"
        @connection.breakup
        flash[:notice] = "Anulowano związek."
      end
      format.html { redirect_to users_path }
    end
  end    
  
  private
  
  def authorize_user   
    @connection = Connection.find(params[:id], :include => [:user, :contact])
    unless current_user?(@connection.user)
      flash[:error] = "Niedozwolone połączenie."
      redirect_to root_path
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Nieprawidłowe albo wygasłe połączenie."
    redirect_to root_path
  end
  
end
