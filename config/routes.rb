Rails.application.routes.draw do
  root 'home#index'
  resource :image
end
