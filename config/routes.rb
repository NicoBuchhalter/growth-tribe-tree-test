require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
 
  resources :trees, only: :show, param: :tree_id do 
  	member do
  		get 'parent/:id', to: 'trees#parent'
  		get 'child/:id', to: 'trees#child'
  	end
  end
end
