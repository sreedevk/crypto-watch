class NewsProvider < ApplicationRecord
  has_many :news_infos
  after_create :update_info

  def fetch_news
    raw_feed = RestClient.get(self.source)
    update_news(raw_feed.body)
  end

  def update_info
    raw_info = RestClient.get(self.source)
    parsed_info = Nokogiri::Slop(raw_info)
    self.update_attributes(description: parsed_info.at_xpath("//rss//channel//description").content, update_frequency: parsed_info.at_xpath("//rss//channel//sy:updatePeriod").content, update_period: parsed_info.at_xpath("//rss//channel//sy:updateFrequency").content)
  end

  private
  
  def update_news(raw_feed)
    parsed_feed = Nokogiri::Slop(raw_feed)
    parsed_feed.rss.channel.item.each do |news|
      NewsInfo.create(title: news.title.content, news_provider_id: self.id, link: news.link.content, enclosure: news.enclosure.attribute("url").value, content: Nokogiri.parse(news.at_xpath(".//description").text.strip).at_css('p').text, categories: news.xpath(".//category").map(&:content))
    end
  end
end
