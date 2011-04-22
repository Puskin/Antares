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
    if @page_id == "map" 
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
  
end
