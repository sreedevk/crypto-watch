class BaseController < ApplicationController
  before_action :authenticate_user!, except: [:newsletter]
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
    params[:per_page] = 12
    @news = NewsInfo.search(params[:keyword]).paginate(index_params)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def monthly_report
    params[:conversion_medium] = "inr" if params[:conversion_medium].blank?
    opts = params.permit!.to_h.with_indifferent_access
    @file_name = Reports.monthly_report(opts)
  end

  def currency_summary
    if params[:currency_id].present?
      params[:convert] ||= "INR"
      params[:per_page] = 10
      @currency_list = Currency.order(:rank).pluck(:name, :id)
      @conversion_medium = params[:convert]&.downcase
      @currency = Currency.find_by(id: params[:currency_id])
      @twitter = TWITTER_CLIENT.search("#{@currency.name} -rt", lang: "en", result_type: "recent", count: 10).to_h
      @news = NewsInfo.search("#{@currency.name}").order(created_at: :desc).last(3)
      @currency_history = CurrencyHistory.where(currency_id: params[:currency_id]).order(created_at: :desc).paginate(index_params)
      render "currency_summary"
    else
      flash[:notice] = "Currency Not Specified"
      redirect_to :dashboard
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def subscribe
    if params[:email].present?
      subscriber = Subscriber.find_or_initialize_by(email: params[:email])
      if subscriber.new_record?
        render json: { status: 'notice', message: "Thank you for subscribing to our newsletter, #{params[:name]}" }, status: 200
      else
        subscriber.update(name: params[:name], email: params[:email])
        render json: { status: 'failure', message: "Your Email is already on our subscriber's list, #{params[:name]}" }, status: 422
      end
    else
      render json: {status: 'notice', message: "Please Enter Valid Details" }, status: 402
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
