class Currency < ApplicationRecord
  has_many :currency_histories 
  belongs_to :user
end
