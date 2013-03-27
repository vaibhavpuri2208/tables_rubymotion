class EventDetailViewController < UIViewController

  def loadView
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)            
  end  
    
    
   
  def viewDidLoad

    super
    @event = Event.mock_event

    @event_date_label = labelForEventDate
    @event_address_label = labelForEventAddress
    @first_talk_label = labelForFirstTalk
    @second_talk_label = labelForSecondTalk
    @location_label = labelForLocation
    @map_view_for_event = mapViewForEvent
    @button_for_booking = buttonForBooking
    self.view.addSubview( imageViewWithHeader )
    self.view.addSubview( imageViewWithBackground )
    self.view.addSubview( @event_date_label )
    self.view.addSubview( @event_address_label )
    self.view.addSubview( @first_talk_label )
    self.view.addSubview( @second_talk_label )
    self.view.addSubview( @location_label )
    self.view.addSubview( @map_view_for_event )
    self.view.addSubview( buttonForMap )
    self.view.addSubview( @button_for_booking )

    self.title = @event.name
    @event_date_label.text = @event.date_as_text
    @event_address_label.text = @event.address
    @first_talk_label.text = "#{@event.talks[0].title} #{@event.talks[0].speaker}"
    @second_talk_label.text = "#{@event.talks[1].title} #{@event.talks[1].speaker}"
    
    requestUserCurrenLocation
  end

  def imageViewWithHeader
    header_imageview = UIImageView.alloc.initWithImage( UIImage.imageNamed('bgNavigationBar') )

    header_imageview    
  end  

  def imageViewWithBackground
    background_imageview = UIImageView.alloc.initWithImage( UIImage.imageNamed('bgApp') )
    background_imageview.frame = [[0, 64], [320, 396]]
    background_imageview    
  end

  def labelForEventDate
    event_date_label = UILabel.alloc.initWithFrame([ [25,45], [150, 160]])
    event_date_label.numberOfLines = 3
    event_date_label.textColor = UIColor.whiteColor
    event_date_label.backgroundColor = UIColor.clearColor
    event_date_label.font = UIFont.fontWithName('HelveticaNeue-Bold', size:27.0)
    event_date_label    
  end

  def labelForEventAddress
    event_address_label = UILabel.alloc.initWithFrame([ [165,45], [150, 160]])
    event_address_label.numberOfLines = 3
    event_address_label.backgroundColor = UIColor.clearColor
    event_address_label.textColor = UIColor.whiteColor
    event_address_label.shadowColor = UIColor.darkGrayColor
    event_address_label.shadowOffset = [0, -1]
    event_address_label.font = UIFont.fontWithName('HelveticaNeue-Light', size:25.0)    
    event_address_label
  end

  def labelForFirstTalk
    first_talk_label = UILabel.alloc.initWithFrame([ [25,270], [200, 100]])
    first_talk_label.numberOfLines = 2
    first_talk_label.backgroundColor = UIColor.clearColor
    first_talk_label.textColor = UIColor.whiteColor
    first_talk_label.font = UIFont.fontWithName('HelveticaNeue-Light', size:15.0)    
    first_talk_label
  end

  def labelForSecondTalk
    second_talk_label = UILabel.alloc.initWithFrame([ [25,320], [200, 100]])
    second_talk_label.numberOfLines = 2
    second_talk_label.backgroundColor = UIColor.clearColor
    second_talk_label.textColor = UIColor.whiteColor
    second_talk_label.font = UIFont.fontWithName('HelveticaNeue-Light', size:15.0)    
    second_talk_label
  end

  def labelForLocation
    label_for_location = UILabel.alloc.initWithFrame([[25,170], [290, 40]])
    label_for_location.backgroundColor = UIColor.clearColor
    label_for_location.font = UIFont.fontWithName('Helvetica', size:10.0)    
    label_for_location
  end  

  def buttonForMap
    button_for_map = UIButton.buttonWithType( UIButtonTypeRoundedRect )
    button_for_map.frame = [[25, 400], [110, 40]]
    button_for_map.setTitle("View Map", forState:UIControlStateNormal)
    button_for_map.addTarget(self, action:'viewMap', forControlEvents:UIControlEventTouchUpInside)
    
    button_for_map
  end  

  def buttonForBooking
    button_for_booking = UIButton.buttonWithType( UIButtonTypeRoundedRect )
    button_for_booking.frame = [[180, 400], [110, 40]]
    button_for_booking.setTitle("Book Event", forState:UIControlStateNormal)
    button_for_booking.addTarget(self, action:'sign_up', forControlEvents:UIControlEventTouchUpInside)
    
    button_for_booking
  end  

  def viewMap
    @event_map_view_controller = EventMapViewController.alloc.init
    @event_map_view_controller.event = @event
    
    self.view.addSubview( @event_map_view_controller.view )
  end  

  def sign_up
    @button_for_booking.enabled = false
    @button_for_booking.setTitle("Event booked", forState:UIControlStateNormal)
  end  

  def mapViewForEvent
    map_view_for_event = MKMapView.alloc.initWithFrame( [[25,210], [270, 80]] )
    map_view_for_event.mapType = MKMapTypeStandard    
    map_view_for_event
  end

  def viewDidUnload
    super    
    @location_manager.stopUpdatingLocation
    @location_manager.delegate = nil
    @event_date_label = nil
    @event_address_label = nil
    @first_talk_label = nil
    @second_talk_label = nil
    @location_label = nil
    @map_view_for_event = nil
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

  def requestUserCurrenLocation
    if (CLLocationManager.locationServicesEnabled)
      @location_manager = CLLocationManager.alloc.init

      #Play with other possible values: KCLLocationAccuracyBest, KCLLocationAccuracyHundredMeters, etc.
      @location_manager.desiredAccuracy = KCLLocationAccuracyKilometer
      
      #Set the current view controller as the delegate of the Location Manager, the location manager will notify of any changes in the location.
      @location_manager.delegate = self

      @location_manager.purpose = "To provide functionality based on user's current location" 
      @location_manager.startUpdatingLocation
    else
      showAlertWithTitle('Location Error', 'Please enable the Location Services for this app in Settings.')  
    end    
  end  

  def showAlertWithTitle(title, andMessage:message)
    alert_view = UIAlertView.alloc.initWithTitle( title, 
                                                  message:message, 
                                                  delegate:nil, 
                                                  cancelButtonTitle:"Ok", 
                                                  otherButtonTitles:nil )
    alert_view.show
  end 

  #CLLocationManagerDelegate methods   
  
  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)    
    @location_label.text = "Latitude:#{newLocation.coordinate.latitude} Longitude:#{newLocation.coordinate.longitude}"   
  end

  def locationManager(manager, didFailWithError:error)
    showAlertWithTitle( "Error", andMessage:error.description )
  end
end
