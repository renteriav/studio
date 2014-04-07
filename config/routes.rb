Studio::Application.routes.draw do

  devise_scope :user do

    authenticated :user, lambda { |user| user.loginable_type == "Admin" } do
      root to: "customers#index"
    end

    authenticated :user, lambda { |user| user.loginable_type == "Teacher" } do
      root to: "teachers#personal", as: :teacher_root
    end

    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  devise_for :users, :controllers => {:registrations => "registrations"} 

  get '/daily', to: 'calendars#daily'
  
  get 'update_teachers', to: 'shared#update_teachers'
  
  get "lessons/teacher_booking"
  
  resources :lessons do
    get "sub_request", to: "attendances#sub_request"
    resources :attendances
  end
  
  get "extras/teacher_booking"
  
  resources :extras do
    resources :attendances
  end
  
  get "attendances/dialog"

  resources :instruments

  resources :rooms

  resources :teachers do
    devise_for :users, :controllers => {:registrations => "registrations"} 
    get 'weekly', to: 'calendars#weekly'
    get '/daily', to: 'calendars#daily'
  end
  
  get 'teachers_cbx', to: 'sharings#teachers_cbx'
  
  get 'sharing_search', to: 'detailed_sharings#sharing_search'
  
  match "update_attendance", to: "detailed_sharings#update_attendance", :via => :put
  
  resources :sharings do
    get "attendance", to: "detailed_sharings#attendance"
  end

  get 'attendance_search', to: 'students#attendance_search'
  
  resources :students do
    get 'attendance', to: 'students#attendance'
    resources :lessons
    resources :extras
    resources :detailed_sharings
  end
  
  get "customers/live_search"
  
  resources :customers do
    resources :students
    resources :telephones
    resources :addresses do
      resources :preffered_addresses
    end
    
  
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
