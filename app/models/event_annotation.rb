class EventAnnotation 

  # attr_accessor :coordinate, :title, :subtitle 

  def initWithCoordinate( coordinate, title:title, andSubTitle:subtitle)        
    @coordinate = coordinate
    @title = title
    @subtitle = subtitle
    
    self
  end

  def coordinate 
   @coordinate 
  end
  
  def title 
    @title
  end
  
  def subtitle 
   @subtitle 
  end

end