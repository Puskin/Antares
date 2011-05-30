class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery
  
  before_filter :set_timezone

    def set_timezone
      Time.zone = "Warsaw"
    end
    
end
