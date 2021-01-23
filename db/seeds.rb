# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  {
    id: 1,
    title: 'YahooNews IT',
    rss_url: 'https://news.yahoo.co.jp/rss/topics/it.xml',
    category: 'tech'
  },
  {
    id: 2,
    title: 'YahooNews 経済',
    rss_url: 'https://news.yahoo.co.jp/rss/topics/business.xml',
    category: 'economy'
  }
].each do |hash|
  news_site = NewsSite.find_or_initialize_by(id: hash[:id])
  news_site.title = hash[:title]
  news_site.rss_url = hash[:rss_url]
  news_site.category = hash[:category]
  news_site.save!
end