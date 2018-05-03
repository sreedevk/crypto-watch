class MarketWatchWorker
  include Sidekiq::Worker

  def perform(opts="")
    get_data(opts) 
  end

  def get_data(opts)
    data_response = RestClient.get("#{COINMARKETCAP_URL}?#{opts}")
    data_parsed = JSON.parse(data_response.body)
    feed_data(data_parsed)
  rescue => e
    logger.fatal "Couldn't GET API Data: #{e}"
  end

  def feed_data(raw_data)
    raw_data.try(:[], "data").try(:each) do |currency_id, currency_info|
      data_build = {}
      data_build[:name] = currency_info.try(:[], "name")
      data_build[:symbol] = currency_info.try(:[], "symbol")
      data_build[:rank] = currency_info.try(:[], "rank")
      data_build[:current_price] = currency_info.try(:[], "quotes").try(:[], "USD").try(:[], "price")
      data_build[:circulating_supply] = currency_info.try(:[], "circulating_supply")
      data_build[:total_supply] = currency_info.try(:[], "total_supply")
      data_build[:max_supply] = currency_info.try(:[], "max_supply")
      data_build[:price_eur] = currency_info.try(:[], "quotes").try(:[], "EUR").try(:[], "price")
      data_build[:price_inr] = currency_info.try(:[], "quotes").try(:[], "INR").try(:[], "price")
      data_build[:volume_24h_usd] = currency_info.try(:[], "quotes").try(:[], "USD").try(:[], "volume_24h")
      data_build[:volume_24h_inr] = currency_info.try(:[], "quotes").try(:[], "INR").try(:[], "volume_24h")
      data_build[:volume_24h_eur] = currency_info.try(:[], "quotes").try(:[], "EUR").try(:[], "volume_24h")
      data_build[:perc_change_1h_usd] = currency_info.try(:[], "quotes").try(:[], "USD").try(:[], "percent_change_1h")
      data_build[:perc_change_24h_usd] = currency_info.try(:[], "quotes").try(:[], "USD").try(:[], "percent_change_24h")
      data_build[:perc_change_7d_usd] = currency_info.try(:[], "quotes").try(:[], "USD").try(:[], "percent_change_7d")
      data_build[:perc_change_1h_inr] = currency_info.try(:[], "quotes").try(:[], "INR").try(:[], "percent_change_1h")
      data_build[:perc_change_24h_inr] = currency_info.try(:[], "quotes").try(:[], "INR").try(:[], "percent_change_24h")
      data_build[:perc_change_7d_inr] = currency_info.try(:[], "quotes").try(:[], "INR").try(:[], "percent_change_7d")
      data_build[:perc_change_1h_eur] = currency_info.try(:[], "quotes").try(:[], "EUR").try(:[], "percent_change_1h")
      data_build[:perc_change_24h_eur] = currency_info.try(:[], "quotes").try(:[], "EUR").try(:[], "percent_change_24h")
      data_build[:perc_change_7d_eur] = currency_info.try(:[], "quotes").try(:[], "EUR").try(:[], "percent_change_7d")
      data_build[:market_cap_usd] = currency_info.try(:[], "quotes").try(:[], "USD").try(:[], "market_cap")     
      data_build[:market_cap_inr] = currency_info.try(:[], "quotes").try(:[], "INR").try(:[], "market_cap")     
      data_build[:market_cap_eur] = currency_info.try(:[], "quotes").try(:[], "EUR").try(:[], "market_cap")     
      data_build[:update_time] = Time.at(currency_info.try(:[], "last_updated").to_i) 
      currency = Currency.find_or_initialize_by(fetch_id: currency_id.to_i)
      log_old_data(currency) unless currency.new_record?
      currency.update_attributes(data_build)
    end
  end


  def log_old_data(currency)
    log_attributes = currency.slice(:current_price, :rank, :circulating_supply, :total_supply, :max_supply, :price_eur, :price_inr, :volume_24h_usd, :volume_24h_inr, :volume_24h_eur, :perc_change_1h_usd, :perc_change_1h_inr, :perc_change_1h_eur, :perc_change_24h_usd, :perc_change_24h_inr, :perc_change_24h_eur, :perc_change_7d_usd, :perc_change_7d_inr, :perc_change_7d_eur, :market_cap_usd, :market_cap_inr, :market_cap_eur, :update_time)
    currency_history = CurrencyHistory.create(log_attributes)
    return currency_history.errors.full_messages.present? ? false : true
  end
end
