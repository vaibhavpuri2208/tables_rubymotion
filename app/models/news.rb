class News

  attr_accessor :title, :brief, :note, :date
 
  def self.news_mock
    mock_data = news_mock_data
    p "news_mock_data #{news_mock_data}"
    news_mock = Array.new
    mock_data.each { |item|      
      news = News.new
      news.title = item["title"] 
      news.brief = item["brief"] 
      news.note = item["index"]
      news.date = NSDate.date
      news_mock << news
    }
    news_mock
  end
  
  def self.news_mock_data
    mock_data_path = NSBundle.mainBundle.pathForResource("news_mock", ofType:"plist")
    news_mock_data = NSArray.arrayWithContentsOfFile mock_data_path
  end


end  