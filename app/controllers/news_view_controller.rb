class NewsViewController < UITableViewController

  NEWS_CELL_REUSE_ID = "NewsCellId"

  def initWithStyle(style)
    super    
    self.title = "News"
    setupTabBarItem
    self
  end  



  def setupTabBarItem  
    tab_bar_item = UITabBarItem.alloc.initWithTitle("", 
      image:nil, tag:1)
    tab_bar_item.setFinishedSelectedImage(UIImage.imageNamed("icnNews"), withFinishedUnselectedImage:UIImage.imageNamed("icnNews"))
    self.tabBarItem = tab_bar_item
  end



  def viewWillAppear(animated)
    super
    load_latest_news

  end


  def load_latest_news
    @news = News.news_mock
    self.tableView.reloadData

  end


  def tableView(tableview, numberOfRowsInSection:section)
    p "------------------ numberOfRowsInSection"

    @news.length
  end


  def tableView(tableview, cellForRowAtIndexPath:indexPath)
    p "------------------ cellForRowAtIndexPath"
    cell = tableView.dequeueReusableCellWithIdentifier(NEWS_CELL_REUSE_ID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: NEWS_CELL_REUSE_ID)
    news_item = @news[ indexPath.row ]
    cell.textLabel.text = news_item.title
    cell.detailTextLabel.text = news_item.brief
    cell
  end

  def tableView(tableview, didSelectRowAtIndexPath: indexPath)

    p "row #{indexPath.row} selected"
  end


 def tableView(tableview, viewForHeaderInSection:section)
  header_view = UIImageView.alloc.initWithImage(UIImage.imageNamed("bgTitleBar"))
  header_view.frame = [[0,0],[320,44]]
  header_view.setUserInteractionEnabled(true)
    header_view.addSubview(deleteButton)
  header_view.addSubview(addButton)

  header_view
  end

  def tableView(tableview, heightForHeaderInSection:section)
    64.0
  end



  def deleteButton
    delete_button = UIButton.buttonWithType(UIButtonTypeCustom)
    delete_button.setTitle("Delete", forState:UIControlStateNormal)
    delete_button.frame = [[10, 12], [56, 41]]
    delete_button.setBackgroundImage(UIImage.imageNamed("btnBarRed"), forState:UIControlStateNormal)
    delete_button.addTarget(self,
                            action:"delete_selected_cell",
                            forControlEvents:UIControlEventTouchUpInside)
    delete_button
  end


  def addButton
    add_button = UIButton.buttonWithType(UIButtonTypeCustom)
    add_button.setTitle("Add", forState:UIControlStateNormal)
    add_button.frame = [[250, 12], [56, 41]]
    add_button.setBackgroundImage(UIImage.imageNamed("btnBarRed"), forState:UIControlStateNormal)
    add_button.addTarget(self,
                         action:"add_cell",
                         forControlEvents:UIControlEventTouchUpInside)
    add_button
  end


  def delete_selected_cell
    selected_cell_index_path = self.tableView.indexPathForSelectedRow

    if selected_cell_index_path

      news_item = @news[selected_cell_index_path.row]
      @news.delete(news_item)
      self.tableView.deleteRowsAtIndexPaths([selected_cell_index_path],
                                            withRowAnimation:UITableViewRowAnimationMiddle)
    end
  end


  def add_cell
    random_item = News.self.news_mock[(0..5).to_a.sample]
    index_path = NSIndexPath.indexPathForRow(@news.length, inSection:0)
    @news << random_item
    self.tableView.insertRowsAtIndexPaths([index_path],
                                            withRowAnimation:UITableViewRowAnimationRight)
  end



end  