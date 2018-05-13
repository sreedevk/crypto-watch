class NewsInfo < ApplicationRecord
  belongs_to :news_provider
  serialize :categories

  scope :search, -> (keyword) {
    keyword.present? ? where("news_infos.content ILIKE ? OR news_infos.title ILIKE ?", "%#{keyword}%", "%#{keyword}%").order(created_at: :desc) : all
  }
end
