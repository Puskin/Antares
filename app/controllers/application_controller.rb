class ApplicationController < ActionController::Base
  include SessionsHelper                                    
  has_mobile_fu
  protect_from_forgery
  
  before_filter :set_timezone      
                                                    
  
  if ENV['RAILS_ENV'] == 'production'        
  before_filter :check_uri  	 	
    def check_uri	
      redirect_to request.protocol + "www." + request.host_with_port + request.request_uri if !/^www/.match(request.host)
    end                                           
  end
  

    def set_timezone
      Time.zone = "Warsaw"
    end
    
end
