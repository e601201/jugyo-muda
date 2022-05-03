Rails.application.routes.draw do
  root 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :missions, only: :index
  scope '/mission' do 
    resource :easy, only: %i[show create]
    resource :normal, only: %i[show create]
    resource :hard, only: %i[show create]
  end
end
