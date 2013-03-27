class SignUpViewController < UIViewController

  CLOSE_BUTTON_TAG = 3    
  EMAIL_TEXTFIELD_TAG = 4
  NAME_TEXTFIELD_TAG = 5
  PASSWORD_TEXTFIELD_TAG = 6
  SIGN_UP_BUTTON_TAG = 7

  def viewDidLoad
        
    @email_textfield = self.view.viewWithTag( EMAIL_TEXTFIELD_TAG ) 
    @name_textfield = self.view.viewWithTag( NAME_TEXTFIELD_TAG )    
    @password_textfield = self.view.viewWithTag( PASSWORD_TEXTFIELD_TAG )
    @password_textfield.delegate = self
        
    setupCloseButton    
    setupSignUpButton
    
  end 

  def setupCloseButton      
    @close_button = self.view.viewWithTag(CLOSE_BUTTON_TAG)    
    @close_button.addTarget(self, 
      action:'close', forControlEvents:UIControlEventTouchUpInside)
  end  

  def setupSignUpButton
    @sign_up_button = self.view.viewWithTag( SIGN_UP_BUTTON_TAG )
    @sign_up_button.addTarget(self, 
      action:'sign_up', forControlEvents:UIControlEventTouchUpInside)          
  end

  def sign_up
    if isFormValid 
      close
    else
      showAlert("Error", title:"Please, fill all the fields.")
    end  
  end  

  def close
    dismissModalViewControllerAnimated true
  end  

  def isFormValid
    not @email_textfield.text.empty? and not @password_textfield.text.empty? and not @name_textfield.text.empty?
  end 

  def showAlert(message, title:title)
    alert = UIAlertView.alloc.initWithTitle(title, 
                        message:message, 
                        delegate:self, 
                        cancelButtonTitle:'OK', 
                        otherButtonTitles:nil)
    alert.show
  end 

  #uitextfield delegate methods
  def textFieldShouldReturn( textField )
    textField.resignFirstResponder    
    false
  end
end  