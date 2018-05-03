class BaseController < ApplicationController
  def index
    @currency_info = Currency.paginate(index_params)
  end

  def index_params
    params[:per_page] ||= 10
    params[:page] ||= 1
    attributes = params.permit(:per_page, :page)
    return attributes.to_h
  end
end
