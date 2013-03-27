describe "The Event Details view controller" do
  tests EventDetailViewController
  
  it "has book button" do  
    view('Book Event').should.not == nil
  end

  it "book event" do
    button_to_evaluate = view('Book Event')    
    tap 'Book Event'
    proper_wait 2
    
    button_to_evaluate.titleLabel.text.should == "Event booked"
    
  end
  
end
