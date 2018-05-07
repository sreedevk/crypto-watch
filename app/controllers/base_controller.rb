class BaseController < ApplicationController
  layout 'dashboard'
  def dashboard 
    params[:convert] ||= "INR"
    @conversion_medium = params[:convert]&.downcase
    @top_currencies = Currency.where(name: ["Bitcoin", "Ethereum", "Ripple", "Bitcoin Cash"]).order(:id)
    @currency_info = Currency.order(:id).paginate(index_params)
    session[:notifications] = [{title: "test_title", content: "test_content", icon_class: "fa-usd"}]
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
