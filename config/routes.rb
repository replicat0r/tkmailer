Rails.application.routes.draw do
  root to: 'visitors#index'

  resources :contacts do
  	collection {post :import}
  end
end
