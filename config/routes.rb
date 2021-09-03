Rails.application.routes.draw do






  devise_for :admin,controllers:{
    sessions:      'admin/admins/sessions',
    passwords:     'admin/admins/passwords',
   registrations:  'admin/admins/registrations'
  }
  devise_for :customer,controllers:{
  sessions:      'public/customer/sessions',
  passwords:     'public/customer/passwords',
  registrations: 'public/customer/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   scope module: :public do
    root to:'homes#top'
    get 'about' => 'homes#about'
    resources :items, only:[:index, :show]
    get 'unsubscribe' => 'customers#usubscribe'
    patch 'withdraw' =>  'customers#withdraw'
    resources :customers, only:[:show,:edit,:update]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only:[:index,:update,:destroy,:create]
    post 'confirm' => 'orders#confirm'
    get 'complete' => 'orders#complete'
    resources :orders, only:[:index,:new,:create,:show]
    resources :addresses, only:[:index,:edit,:create,:update,:destroy]
  end
  namespace :admin do
    resources :sessions, only:[:new,:create, :destroy]
    get 'top' => 'homes#top'
    resources :items, only:[:index,:create,:show,:edit,:new,:update]
    resources :genres, only:[:index,:create,:edit, :update]
    resources :customers, only:[:index,:show,:edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
  end
end
