class BaseController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'
  def dashboard 
    params[:convert] ||= "INR"
    @conversion_medium = params[:convert]&.downcase
    @top_currencies = Currency.where(name: ["Bitcoin", "Ethereum", "Ripple", "Bitcoin Cash"]).order(:id)
    @currency_info = Currency.order(:id).paginate(index_params)
    session[:notifications] = Notification.unread(current_user.id).pluck(:title, :content, :icon_name)
  end
  
  private
  def fetch_data
    MarketWatchWorker.perform_async("convert=INR")
  end

  def index_params
    params[:per_page] ||= 10
    params[:page] ||= 1
    attributes = params.permit(:per_page, :page)
    return attributes.to_h
  end
end
