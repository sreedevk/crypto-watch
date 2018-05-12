class NewsInfo < ApplicationRecord
  belongs_to :news_provider
  serialize :categories
end
