class SignInViewController < UIViewController

  HEADER_IMAGE_VIEW_TAG = 1
  BACKGROUND_IMAGE_VIEW_TAG = 2
  CLOSE_BUTTON_TAG = 3
  EMAIL_TEXTFIELD_TAG = 4
  PASSWORD_TEXTFIELD_TAG = 5
  SIGN_IN_BUTTON_TAG = 6

  def viewDidLoad                    
    setupHeaderImageView
    setupBackgroundImageView
    setupEmailTextField
    setupPasswordTextField
    setupCloseButton    
    setupSignInButton
    
  end 

  def setupHeaderImageView
    header_image_view = self.view.viewWithTag( HEADER_IMAGE_VIEW_TAG )
    header_image_view.image = UIImage.imageNamed( 'bgTitleBar' )
  end  

  def setupBackgroundImageView
    background_image_view = self.view.viewWithTag( BACKGROUND_IMAGE_VIEW_TAG )
    background_image_view.image = UIImage.imageNamed( 'bgApp' )
  end  

  def setupEmailTextField
    @email_textfield = self.view.viewWithTag( EMAIL_TEXTFIELD_TAG )
    @email_textfield.background = UIImage.imageNamed( 'bgTextField' )
  end

  def setupPasswordTextField      
    @password_textfield = self.view.viewWithTag( PASSWORD_TEXTFIELD_TAG )
    @password_textfield.background = UIImage.imageNamed( 'bgTextField' )
    @password_textfield.delegate = self
  end

  def setupCloseButton      
    @close_button = self.view.viewWithTag(CLOSE_BUTTON_TAG)    
    @close_button.setBackgroundImage( UIImage.imageNamed("btnCancel"), forState:UIControlStateNormal)
    @close_button.addTarget(self, 
      action:'close', forControlEvents:UIControlEventTouchUpInside)
  end  

  def setupSignInButton
    @sign_in_button = self.view.viewWithTag( SIGN_IN_BUTTON_TAG )
    @sign_in_button.addTarget(self, 
      action:'sign_in', forControlEvents:UIControlEventTouchUpInside)        
    @sign_in_button.setBackgroundImage( UIImage.imageNamed("btnBrown"), forState:UIControlStateNormal)
  end

  def sign_in
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
    not @email_textfield.text.empty? and not @password_textfield.text.empty?
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