class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def error
  	render template: 'errors/404', status: 404
  end
end
