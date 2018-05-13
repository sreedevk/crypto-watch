class BaseController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'
  def dashboard 
    params[:convert] ||= "INR"
    @conversion_medium = params[:convert]&.downcase
    @top_currencies = Currency.where(name: ["Bitcoin", "Ethereum", "Ripple", "Bitcoin Cash"]).order(:id)
    @currency_info = Currency.order(:id).paginate(index_params)
    session[:notifications] = Notification.unread(current_user.id).pluck(:title, :content, :icon_name)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def crypto_news
    @news = NewsInfo.paginate(index_params)
  end

  def currency_summary
    if params[:currency_id].present?
      params[:convert] ||= "INR"
      @conversion_medium = params[:convert]&.downcase
      @currency = Currency.find_by(id: params[:currency_id])
      @twitter = TWITTER_CLIENT.search("#{@currency.name} -rt", lang: "en", result_type: "recent", count: 10).to_h
      @labels = CurrencyHistory.where(currency_id: @currency.id).order(:update_time).pluck(:update_time).map{|x|x.strftime('%I:%M %P')}.uniq.first(10).to_json.html_safe
      @values = CurrencyHistory.where(currency_id: @currency.id).order(:update_time).last(10).send("pluck", current_price(@conversion_medium)).to_json.html_safe 
      render "currency_summary"
    else
      flash[:notice] = "Currency Not Specified"
      redirect_to :dashboard
    end
  end
  
  private
  
  def fetch_data
    MarketWatchWorker.perform_async("convert=INR")
  end
  
  def current_price(conversion_medium)
    conversion_medium.downcase == "usd" ? "current_price" : "price_#{conversion_medium.downcase}"
  end

  def index_params
    params[:per_page] ||= 10
    params[:page] ||= 1
    attributes = params.permit(:per_page, :page)
    return attributes.to_h
  end
end
