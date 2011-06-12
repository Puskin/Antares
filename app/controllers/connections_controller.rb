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
         flash[:success] = "Wyslano zaproszenie!"
         format.html { redirect_to users_path }
       else
         flash[:error] = "Nieprawidlowe polaczenie"
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
        flash[:success] = "Zaakceptowano polaczenie"
      when "Odrzucam"
        @connection.breakup
        flash[:notice] = "Odrzucono polaczenie z #{name}"
      when "Cofnij"
        @connection.breakup
        flash[:notice] = "Anulowano zaproszenie"
      when "Anuluj"
        @connection.breakup
        flash[:notice] = "Anulowano zwiazek"
      end
      format.html { redirect_to users_path }
    end
  end    
  
  private
  
  def authorize_user   
    @connection = Connection.find(params[:id], :include => [:user, :contact])
    unless current_user?(@connection.user)
      flash[:error] = "Niedozwolone polaczenie"
      redirect_to root_path
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Nieprawidlowe albo wygasle polaczenie"
    redirect_to root_path
  end
  
end
