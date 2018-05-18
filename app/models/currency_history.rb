class CurrencyHistory < ApplicationRecord
  belongs_to :currency
  
  def self.monthly_report(currency_id)
    where(currency_id: currency_id).where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)
  end
end
