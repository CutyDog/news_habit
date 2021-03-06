class HomeController < ApplicationController
  
  def top
    @it_items = NewsItem.it.order(published_at: :desc).limit(4)
    @economy_items = NewsItem.economy.order(published_at: :desc).limit(4)
    @business_items = NewsItem.business.order(published_at: :desc).limit(4)
    @sports_items = NewsItem.sports.order(published_at: :desc).limit(4)
    @life_items = NewsItem.life.order(published_at: :desc).limit(4)
    @entertainment_items = NewsItem.entertainment.order(published_at: :desc).limit(4)
    @domestic_items = NewsItem.domestic.order(published_at: :desc).limit(4)
    @international_items = NewsItem.international.order(published_at: :desc).limit(4)
    
    user = current_user
    @name = user&.name
  end
  
  def habit
    user = current_user
    @name = user&.name
    
    @read_reccomends = NewsItem.where.not(id: user.read_log_news_items).order(id: :desc).limit(4)
    @read_logs = user.read_log_news_items.preload(:news_item).order(id: :desc).limit(4)
    
    logs = user.read_log_news_items.where('created_at >= ?', Time.current.beginning_of_day - 7.day)
    gon.week = [0,0,0,0,0,0,0]
    logs.each do |log|
      gon.week[(Time.current.to_date - log.created_at.to_date).to_i] += 1
    end  
    gon.week = gon.week.reverse
    
    records = user.read_log_news_items.where('created_at >= ?', Time.current.beginning_of_day - 30.day)
    gon.month = Array.new(30, 0)
    records.each do |record|
      gon.month[(Time.current.to_date - record.created_at.to_date).to_i] += 1
    end
    gon.month = gon.month.reverse
    gon.label = Array.new(28, "")
    gon.label = gon.label.unshift("30日前")
    gon.label = gon.label.push("今日")
    
  end
  
end
