Traces::Application.routes.draw do

  ## routes for sql implement
  # devise_for :admins, :controllers => { :registrations => "registrations" }, :path_names => { :sign_up => "new" }
  #
  #   resources :posts, :except => :index do
  #     resources :comments
  #     resources :terms
  #     resources :tags
  #   end
  #
  #   resources :terms do
  #     resources :posts
  #   end
  #
  #   resources :tags do
  #     resources :posts
  #   end
  #
  #   root :to => "posts#index"
  #
  #   match '/feed' => 'posts#feed'

  #clea the uri from "2010/XXX" or "2010/09/XXX" all to "2010/09/23/XXX"
  # match "/:year(/:month)/:title" => "posts#show_redirect",
  #   :constraints => { :year => /\d{4}/, :month => /0[1-9]|1[0-2]/, :slug => /\d-.*/ }
  #
  #   match "/:year((/:month(/:day))(/:title))" => "posts#show_all",
  #   :constraints => { :year => /\d{4}/, :month => /0[1-9]|1[0-2]/, :day => /0[1-9]|1\d|2\d|3[0-1]/ }

  ## routes for CouchDB
  devise_for :users, :controllers => { :registrations => "registrations" }, :path_names => { :sign_up => "new" }
  devise_for :users, :controllers => { :session => "session" }

  resources :diaries
  resources :articles do
    resources :comments
  end
  resources :comments

  #root :to => "articles#index"
  root :to => 'backbone#index'

  match '/drafts' => 'articles#drafts'
  match '/feed' => 'articles#feed'
  match '/sitemap' => 'sitemap#index'

  match "/:year(/:month)/:slug" => "articles#show_redirect",
  :constraints => { :year => /\d{4}/, :month => /0[1-9]|1[0-2]/, :slug => /\d{3,}|\D+/ }

  match "/:year((/:month(/:day))(/:slug))" => "articles#show_all",
  :constraints => { :year => /\d{4}/, :month => /0[1-9]|1[0-2]/, :day => /0[1-9]|1\d|2\d|3[0-1]/ }

  match '/users/signed_in_check' => 'backbone#signed_in_check'

  # match '/:id' => 'posts#show', :constraints => { :id => /\d.+/ }
  # match '/:username' => 'users#show'
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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
