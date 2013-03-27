describe "Event" do
  
  DAYS_LEFT = 10

  NEGATIVE_PAST_DAYS = -10

  before do
    @event = Event.mock_event
  end

  it "should count days left until future date" do 

    future_date = date_adding_days( DAYS_LEFT )    
    days_left_until_future_date = @event.days_left_until( future_date )
    days_left_until_future_date.should.equal DAYS_LEFT
  end

  it "should count days left as 0 for past date" do    
    past_date = date_adding_days( NEGATIVE_PAST_DAYS )
    days_left_until_past_date = @event.days_left_until( past_date )
    days_left_until_past_date.should.equal 0
  end

  it "should count days left as 0 for current date" do    
    today = NSDate.date
    days_left_until_today = @event.days_left_until( today )
    days_left_until_today.should.equal 0
  end

  def date_adding_days( days_to_add )
    components = NSDateComponents.alloc.init
    components.day = days_to_add
    gregorian = NSCalendar.alloc.initWithCalendarIdentifier( NSGregorianCalendar )
    gregorian.dateByAddingComponents( components, toDate:Time.now, options:0 )    
  end    
  
end  