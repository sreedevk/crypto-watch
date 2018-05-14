Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'base#dashboard'
  root to: 'website#index'
  get '/dashboard', to: 'base#dashboard'
  get '/crypto_news', to: 'base#crypto_news'
  get '/currency_summary', to: 'base#currency_summary'
  get '/newsletter', to: 'base#newsletter'
  get "*unmatched_route", to: 'application#error'
  post '/newsletter', to: 'base#subscribe'
end
