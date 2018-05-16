class Api::CurrencyController < ApplicationController
  def currency_history
    params[:currency_id] ||= 1
    currency_history = CurrencyHistory.where(currency_id: params[:currency_id])
    render json: currency_history
  end
end
