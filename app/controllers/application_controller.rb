class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery
  
  before_filter :set_timezone                        
  before_filter :check_uri

    def check_uri
      redirect_to request.protocol + "www." + request.host_with_port + request.request_uri if !/^www/.match(request.host)
    end
  

    def set_timezone
      Time.zone = "Warsaw"
    end
    
end
