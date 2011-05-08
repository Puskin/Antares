xml.dane do
  @contacts.each do |marker|     
	  location = Location.for_user(marker).first
	  xml.marker( :lat => location.latitude, :lon => location.longitude, :nazwa => marker.name, :opis => location.description, :tytul => location.title, )
  end
end