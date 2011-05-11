module ApplicationHelper
  
  def title
      base_title = "Jetu - "
      if @title.nil?
        base_title
      else
        "#{base_title}#{@title}"
      end
  end
  
  def container_size #for full width container after login   
    case @page_id    
      when "map"
        "containerFull"
      when "map_add"
        "containerFull"
      else
        "container"    
    end              
  end        
  
  def body_class
   if signed_in? && @page_id == nil
     "class='subpage'"
   end       
  end
  
  def show_header
    if signed_in?
		  render 'layouts/header_user'
    else
      render 'layouts/header'
    end
  end        
  
  def contacts_notifications 
    requests = current_user.requested_contacts.count 
    if requests > 0
      requests
    else
      ""
    end
  end
  
end
