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
    if signed_in? 
      "containerFull"
    else
      "container"
    end
  end
  
  def body_height 
    if @page_height == "full"
      "class='fullHeight'"
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
