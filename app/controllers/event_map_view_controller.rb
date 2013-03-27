class EventMapViewController < UIViewController

  attr_accessor :event


  def loadView    
    self.view = UIView.alloc.initWithFrame( UIScreen.mainScreen.bounds )
    
  end
    

  def viewDidLoad    
    super    
    @map_view_for_event = mapViewWithEventLocation
    self.view.userInteractionEnabled = true
    annotation = EventAnnotation.alloc.initWithCoordinate(@event.location, title:event.name, andSubTitle:event.address)
    @map_view_for_event.addAnnotation(annotation)    
    
    @map_view_for_event.setRegion(regionForEventLocation)

    self.view.addSubview( @map_view_for_event )
    self.view.addSubview( segmentedControlWithMapOptions )
    self.view.addSubview( buttonToCloseScreen )
  end



  def mapViewWithEventLocation
    map_view_for_event = MKMapView.alloc.initWithFrame( self.view.bounds )
    map_view_for_event.mapType = MKMapTypeStandard  
    map_view_for_event.showsUserLocation = true  
    
    map_view_for_event
  end

  def regionForEventLocation
    region = MKCoordinateRegionMake(@event.location, MKCoordinateSpanMake(0.7, 0.7)) 
    region
  end  

  def segmentedControlWithMapOptions
    segmented_control_with_map_options = UISegmentedControl.alloc.initWithItems(['Standard', 'Satellite', 'Hybrid'])
    segmented_control_with_map_options.frame = [[40, 400], [280,40]]
    segmented_control_with_map_options.addTarget(self,
                                       action:"switch_map_type:",
                                       forControlEvents:UIControlEventValueChanged)
    segmented_control_with_map_options.setEnabled(true, forSegmentAtIndex:0)
    segmented_control_with_map_options
  end  

  def buttonToCloseScreen
    close_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    close_button.setTitle("Close", forState:UIControlStateNormal)
    close_button.frame = [[250, 5], [60, 40]]
    close_button.addTarget(self, action:"close", forControlEvents:UIControlEventTouchUpInside)    
    close_button
  end  

  def switch_map_type(segmented_control)    
    @map_view_for_event.mapType = case segmented_control.selectedSegmentIndex
      when 0 then MKMapTypeStandard
      when 1 then MKMapTypeSatellite
      when 2 then MKMapTypeHybrid  
    end
  end     

  def close
    self.view.removeFromSuperview
  end  

  def viewDidUnload
    super
    @map_view_for_event = nil
  end

  

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
