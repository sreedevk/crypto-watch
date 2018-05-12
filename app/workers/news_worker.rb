class NewsWorker
  include Sidekiq::Worker
  def perform(news_provider_id)
    NewsProvider.find_by(id: news_provider_id)&.fetch_news
  end
end
