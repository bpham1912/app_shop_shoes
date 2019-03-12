Rails.application.routes.draw do
  #resources :categories
  #get 'admins/categories', to: 'categories#index'
  root 'pages#home'
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
   authenticate :admin do
  #   scope '/admins' do
  #     #rails_admin admin panel
  #     mount RailsAdmin::Engine => '/', as: 'rails_admin'
  #     #get '/product/:id/edit',to: ' rails_admin/main#edit'
  #     # resources :products
  #     get '/products/:id/edit', to: 'products#edit'
  #   end
  # end
  #mount RailsAdmin::Engine => '/admins/database/', as: 'rails_admin'
  
  scope '/admins' do
    root 'admins#homepage'
    resources :admins
    resources :products
    resources :categories
    resources :manages
    resources :users
    
  end
end
scope '/' do
  resources :products,only: [:show]
end
 
  #user
  
  get 'contact', to: 'pages#contact'
   get 'login', to: 'sessions#new'
  get 'signup', to: 'users#new'
  get 'users/signup'
  get 'errors/loi'
  #resources :categories, except: [:show]

  #root :to 'admins#adminshome'
  #resources :admins, except: [:show]
  #resources :users, except: [:show]
  #resources :uploads, only: [:index, :show, :update, :create]
  #resources :settings, only: [:index, :edit, :update]
 

  #resources :categories
  resources :users, except: [:destroy, :index]
  #resources :products

  delete 'images', to:  'products#destroyimage'

  
end
