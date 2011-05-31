xml.dane do
  @contacts.each do |marker|                  
    unless marker.locations.empty?
	    location = Location.for_user(marker).first
  	  xml.marker(
  	    :lat => location.latitude, 
  	    :lon => location.longitude, 
  	    :nazwa => marker.name, 
  	    :opis => location.description, 
  	    :tytul => location.title, 
  	    :ikona => GravatarImageTag.gravatar_url(marker.email, :size => 35)
  	    )
	  end
  end
end