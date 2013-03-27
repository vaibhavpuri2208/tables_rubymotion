class Event 

	attr_accessor :name, :address, :location, :date_as_text, :talks, :date

  CUPERTINO_LOCATION = {:latitude => 37.334815, :longitude => -122.029781}

	def self.mock_event

		mock_event = Event.new
		mock_event.name = "November meeting"
    mock_event.address = "Main St 107, Westlake, Seatle MA" 
    mock_event.date_as_text = "Sat 14th November 2012"
    mock_event.date = date_adding_days( 7 )
		mock_event.location = CLLocationCoordinate2DMake( CUPERTINO_LOCATION[:latitude], CUPERTINO_LOCATION[:longitude] )
    mock_event.talks = [Talk.mock_talk, Talk.mock_talk]
    mock_event
	end		

  def days_left_until( future_date )
    today = NSDate.date
    days_left = days_between(today, and:future_date)
    if ( days_left < 0 )
      days_left = 0
    end  
    days_left
  end  

  def days_between( first_date, and:second_date )
    
    unitFlags = NSDayCalendarUnit | NSHourCalendarUnit
    calendar = NSCalendar.alloc.initWithCalendarIdentifier(NSGregorianCalendar)
    components = calendar.components(unitFlags, 
                            fromDate:date_with_time_normalized( first_date ), 
                              toDate:date_with_time_normalized( second_date ), 
                             options:NSWrapCalendarComponents)
    p "hours #{components.hour} days #{components.day}"
    components.day 

  end 

  def date_with_time_normalized( date_to_normalize )
    Time.local( date_to_normalize.year, date_to_normalize.month, date_to_normalize.day, 0, 1, 0)
  end   

  def self.date_adding_days( days_to_add )
    components = NSDateComponents.alloc.init
    components.day = days_to_add
    gregorian = NSCalendar.alloc.initWithCalendarIdentifier( NSGregorianCalendar )
    gregorian.dateByAddingComponents( components, toDate:Time.now, options:0 )    
  end    
end