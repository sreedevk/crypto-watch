COINDELTA_URL = "https://coindelta.com/api/v1/public/getticker/"
COINMARKETCAP_URL = "https://api.coinmarketcap.com/v2/ticker/"
TWITTER_CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = "q5Kke3EueaZuMZTXmNIl43h3c"
  config.consumer_secret     = "NuC47LcdZkz0EMypDJJlyze8zb6xAzYCbdWJReBS3cxdN4AgjC"
  config.access_token        = "128633232-XzObU3YJTQlSbgJzGggRxNUs7wa5XIBD35tk5L6Q"
  config.access_token_secret = "Z8CmWPN2SRhbEzUowtyMiafAjYAkcn9NzSj5IGH7eQuRE"
end
