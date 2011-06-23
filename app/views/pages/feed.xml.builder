xml.dane do
  @contacts.each do |marker|                  
    unless marker.locations.empty?
	    location = Location.for_user(marker).first
  	  xml.marker(
  	    :lat => location.latitude, 
  	    :lon => location.longitude, 
  	    :nazwa => "#{marker.name} #{marker.surname}", 
		:czas => "#{time_ago_in_words(location.created_at)} temu",
  	    :opis => location.description, 
  	    :tytul => location.title, 
  	    :ikona => GravatarImageTag.gravatar_url(marker.email, :size => 39)
  	    )
	  end
  end 
  
  user = current_user.locations.first
  unless user.blank?          
    xml.marker(
	    :lat => user.latitude, 
	    :lon => user.longitude, 
	    :nazwa => "Ja", 
	    :czas => "#{time_ago_in_words(user.created_at)} temu",
		:opis => user.description, 
	    :tytul => user.title,    
	    :ikona => GravatarImageTag.gravatar_url(current_user.email, :size => 39)  
	    )
  end
    
end