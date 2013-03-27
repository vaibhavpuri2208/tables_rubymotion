class NextEventViewController < UIViewController
  

  EVENT_NAME_TEXT = "November meeting."

  def init    
    super
    @days_left = 0
    self.title = "Next Event"
    setupTabBarItem
    self
  end  

  def loadView    
    self.view = UIView.alloc.initWithFrame( UIScreen.mainScreen.bounds )
    self.view.backgroundColor = UIColor.whiteColor
    
  end

  def setupTabBarItem  
    tab_bar_item = UITabBarItem.alloc.initWithTitle("", 
      image:nil, tag:1)
    tab_bar_item.setFinishedSelectedImage(UIImage.imageNamed("icnCurrent"), withFinishedUnselectedImage:UIImage.imageNamed("icnCurrent"))
    self.tabBarItem = tab_bar_item
  end   
    
  def viewDidLoad    
    super
    
    self.view.addSubview( imageViewWithHeader )
    self.view.addSubview( imageViewWithBackground )
    self.view.addSubview( imageViewWithTitleBackground )
    @next_event_name_label = labelWithNextEventName
    @days_left_view = viewWithDaysLeft
    self.view.addSubview( @next_event_name_label )
    @event = Event.mock_event
    self.view.addSubview( buttonForSignIn )
    self.view.addSubview( buttonForSignUp )
    self.view.addSubview( @days_left_view )
    self.view.addSubview( buttonToChangeDaysLeft )
    
    @next_event_name_label.text = @event.name

  end

  def viewWillAppear(animated)
    super
    @days_left = @event.days_left_until( @event.date )
  end

  def viewDidAppear(animated)
    super
    @days_left_view.days_left = @days_left
    @days_left_view.setNeedsDisplay
  end    

  def labelWithNextEventName
    next_event_name_label = UILabel.alloc.initWithFrame( [[60, 135], [275, 40]] )
    
    next_event_name_label.font = UIFont.fontWithName("AmericanTypewriter-CondensedBold", size:30)
    next_event_name_label.backgroundColor = UIColor.clearColor
    next_event_name_label.textAlignment = UITextAlignmentCenter
    next_event_name_label.textColor = UIColor.whiteColor
    next_event_name_label.shadowColor = UIColor.darkGrayColor
    next_event_name_label.shadowOffset = [-1,-1]
    next_event_name_label

  end

   

  def imageViewWithHeader
    header_imageview = UIImageView.alloc.initWithImage( UIImage.imageNamed('bgTitleBar') )

    header_imageview    
  end  

  def imageViewWithBackground
    background_imageview = UIImageView.alloc.initWithImage( UIImage.imageNamed('bgApp') )
    background_imageview.frame = [[0, 64], [320, 416]]
    background_imageview    
  end

  def imageViewWithTitleBackground
    title_background_imageview = UIImageView.alloc.initWithImage( UIImage.imageNamed('bgEventTitle') )
    title_background_imageview.frame = [[0, 103], [320, 103]]
    title_background_imageview    
  end  

  def buttonForSignIn
    sign_in_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    sign_in_button.frame = [[15, 280], [295, 40]]
    
    sign_in_button.setTitle("I have an account, sign-in to book", forState:UIControlStateNormal)
    sign_in_button.setTitle("is Highlighted", forState:UIControlStateHighlighted)    
    sign_in_button.addTarget(self, action:'sign_in:', forControlEvents:UIControlEventTouchUpInside)
    
    sign_in_button
  end  

  def buttonForSignUp
    sign_up_button = UIButton.buttonWithType(UIButtonTypeCustom)    
    sign_up_button.frame = [[15, 350], [295, 40]] 
    
    sign_up_button.setTitle("Don't have an account, sign-up", forState:UIControlStateNormal)
    sign_up_button.titleLabel.font = UIFont.fontWithName("HelveticaNeue-Light", size:18)
    sign_up_button.setBackgroundImage( UIImage.imageNamed("btnBrown"), forState:UIControlStateNormal)
    sign_up_button.addTarget(self, action:'sign_up', forControlEvents:UIControlEventTouchUpInside)
    sign_up_button
  end 

  def buttonToChangeDaysLeft
    change_days_left_button = UIButton.buttonWithType(UIButtonTypeCustom)    
    change_days_left_button.frame = [[15, 420], [295, 40]]
    change_days_left_button.setTitle("Change days left", forState:UIControlStateNormal)   
    change_days_left_button.setBackgroundImage( UIImage.imageNamed("btnBrown"), forState:UIControlStateNormal) 
    change_days_left_button.addTarget(self, action:'change_days_left', forControlEvents:UIControlEventTouchUpInside)
    change_days_left_button
  end  


  def viewWithDaysLeft
    days_left_view = FlipCountView.alloc.initWithFrame( [[10, 120], [68, 74]] )    
    
    days_left_view
  end  
  
  def viewDidUnload    
    super
    @next_event_name_label = nil
    @days_left_view = nil
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    #change this to enable rotation to landscape orientation    
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

  def change_days_left
    @days_left = @days_left + 1 
    @days_left_view.days_left = @days_left
    @days_left_view.setNeedsDisplay
  end  

  def sign_in( button )
    signin_controller = SignInViewController.alloc.initWithNibName("RBMViewController", bundle:nil)
    presentModalViewController(signin_controller, animated:true)
  end

  def sign_up
    signup_controller = SignUpViewController.alloc.initWithNibName("SignUpView", bundle:nil)
    presentModalViewController(signup_controller, animated:true)
  end
       
end
