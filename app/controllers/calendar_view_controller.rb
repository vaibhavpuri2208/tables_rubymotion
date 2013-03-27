class CalendarViewController < UIViewController

  def init    
    super    
    self.title = "Calendar"
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
    tab_bar_item.setFinishedSelectedImage(UIImage.imageNamed("icnCalendar"), withFinishedUnselectedImage:UIImage.imageNamed("icnCalendar"))
    self.tabBarItem = tab_bar_item
  end   

  def viewDidLoad
    @text_view = text_view_for_messages
    self.view.addSubview( @text_view )
  end

  def text_view_for_messages
    text_view = UITextView.alloc.initWithFrame( [[20,40], [300, 300]] )    
    text_view.textColor = UIColor.redColor
    text_view.editable = false
    text_view
  end

  def viewDidUnload
    @text_view.text = "#{@text_view.text} view did unload\n"
  end  

  def viewDidAppear(animated)
    super
    @text_view.text = "#{@text_view.text} view did appear\n"
  end    

  def viewDidDisappear(animated)
    super
    @text_view.text = "#{@text_view.text} view did disappear\n"
  end
  
  def viewWillAppear(animated)
    super
    @text_view.text = "#{@text_view.text} view will appear\n"
  end
  
  def viewWillDisappear(animated)
    super
    @text_view.text = "#{@text_view.text} view will disappear\n"
  end    
end  