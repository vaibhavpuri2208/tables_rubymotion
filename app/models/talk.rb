class Talk

  attr_accessor :title, :speaker

  MOCK_TITLE = "Advanced Data Persistence with CoreData"

  MOCK_SPEAKER = "John Doe"

  def self.mock_talk
    mock_talk = Talk.new
    mock_talk.title = MOCK_TITLE
    mock_talk.speaker = MOCK_SPEAKER
    mock_talk
  end  

end  