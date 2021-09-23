Rails.application.routes.draw do
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
      resources :orders, only:[:show,:update] do
      resources :order_details, only:[:update]
    end
      get '' => 'homes#top'
    end
    
    scope module: :public do
      devise_for :customers, path_names: { edit: 'fare'}
      resources :items,only:[:index,:show]
      resource :customers,only:[:show,:edit,:update]
      get 'orders/thanks' => 'orders#thanks'
      resources :cart_items, only:[:index,:update,:create,:destroy]
      resources :orders, only:[:index,:show,:new,:create] 
      resources :addresses, except:[:new]
      get 'top' => 'homes#top'
      root to: 'homes#top'
      get 'about' => 'homes#about'
      get 'customers/quit' => 'customers#quit'
      patch 'customers/leave' => 'customers#leave'
      delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
      post 'orders/comfirm' => 'orders#comfirm'
    end
end
