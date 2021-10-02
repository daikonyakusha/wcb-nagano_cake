Rails.application.routes.draw do
  get 'search/search'
  devise_for :admin, controllers: {
    sessions:      'admin/sessions',
    passwords:     'admin/passwords',
    registrations: 'admin/registrations'
  }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    namespace :admin do
      resources :items
      resources :genres, except:[:new,:show]
      resources :customers, except:[:new,:create]
      resources :orders, only:[:show,:update] 
      resources :order_details, only:[:update]
      get '' => 'homes#top'
    end
    
    scope module: :public do
      resource :customers,only:[:show,:edit,:update]
      devise_for :customers, path_names: { edit: 'fare'}
      resources :items,only:[:index,:show]
      post 'orders/comfirm' => 'orders#comfirm'
      get 'orders/thanks' => 'orders#thanks'
      delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
      resources :cart_items, only:[:index,:update,:create,:destroy]
      resources :orders, only:[:index,:show,:new,:create] 
      resources :addresses, except:[:new]
      get 'top' => 'homes#top'
      root to: 'homes#top'
      get 'about' => 'homes#about'
      get 'customers/quit' => 'customers#quit'
      patch 'customers/leave' => 'customers#leave'
    end
end
