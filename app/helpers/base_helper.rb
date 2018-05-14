module BaseHelper
  def color_class(value)
    value.to_f.negative? ? "red" : "green"
  end

  def current_price(conversion_medium)
    conversion_medium.downcase == "usd" ? "current_price" : "price_#{conversion_medium.downcase}"
  end

  def arrow_name(value)
    raw(value.to_f.negative? ? "&searr;" : "&nearr;")
  end

  def shortened_value_inr(value)
    if value < 1_000
      return value
    elsif value < 1_00_000 && value > 1_000
      return "#{(value/1000.to_f).round(2)}K"
    elsif value < 1_00_00_000 && value > 1_00_000
      return "#{(value/1_00_000.to_f).round(2)}L"
    elsif value > 1_00_00_000
      return "#{(value/1_00_00_000.to_f).round(2)}C"
    else
      return value
    end
  end

  def shortened_value_usd(value)
    if value < 1_000
      return value
    elsif value < 1_000_000 && value > 1_000
      return "#{(value/1_000.to_f).round(2)}K"
    elsif value < 1_000_000_000 && value > 1_000_000
      return "#{(value/100_000.to_f).round(2)}M"
    elsif value > 1_000_000_000
      return "#{(value/1_000_000_000.to_f).round(2)}B"
    end
  end

  def chart(currency)
    currency_histories = CurrencyHistory.where(currency_id: currency.id).last(10)
    labels = currency_histories.pluck(:created_at).map{|x| x.strftime("%I:%M %P")}
    values = currency_histories.send("pluck", current_price(@conversion_medium))
    return {labels: labels, series: [values]}.to_json.html_safe
  end

  alias shortened_value_eur shortened_value_usd
end
