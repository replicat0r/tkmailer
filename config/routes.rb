Rails.application.routes.draw do
  root to: 'visitors#index'

  resources :contacts do
  	collection {post :import}
  	collection {get :send_email}
  end
end
