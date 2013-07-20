NeptuneMusic::Application.routes.draw do

  get "audio/create"

  get "images/new"

  get "images_controller/new"

  # Routes for beta subdomain
  constraints subdomain: "beta" do
    # Routes for resources
    resources :users
    resources :events
    resources :albums
    resources :songs  # TODO: albums and songs should probably be subresources of artists
    resources :images
    resources :audio
    resources :events

    root to: 'home#home'

    get "/login" => "login#login", as: :login
    post "/login" => "login#sign_in_user", as: :sign_in
    post "/login/create" => "login#create_new_user", as: :login_create_user
    post "/login/fb_login" => "login#fb_login", as: :fb_login
    match 'logout', to: 'login#destroy', as: :logout

    match '/pwhelp', to: 'login#password_help', as: :pwhelp
    get "/pwreset" => 'login#reset_password', as: :resetpw
    match '/pwchange', to: 'login#password_change', as: :pwchange
    post "/changepw" => 'login#change_password', as: :changepw

    match '/upload', to: 'users#upload', as: :upload
    post '/:artistname/update_content', to: 'artists#update_content', as: :update_content
    post '/:artistname/remove_media', to: 'artists#remove_media', as: :remove_media

    match '/json/album_name_suggestions', to: 'albums#album_name_suggestions', as: :album_name_suggestions

    match '/:artistname', to: 'artists#show', as: :artist_main
    match '/:artistname/about', to: 'artists#about', as: :artist_about
    match '/:artistname/music', to: 'artists#music', as: :artist_music
    match '/:artistname/events', to: 'artists#events', as: :artist_events
    match '/:artistname/burble', to: 'artists#burble', as: :artist_burble
    match '/:artistname/fans', to: 'artists#fans', as: :artist_fans
    match '/:artistname/albums/new', to: 'albums#new', as: :new_album_for_artist
    match '/:artistname/albums/:album', to: 'albums#show', as: :album_for_artist
    match '/:artistname/songs/new', to: 'songs#new', as: :new_song_for_artist
    match '/:artistname/songs/:song', to: 'songs#show', as: :song_for_artist
    match '/:artistname/events/new', to: 'events#new', as: :new_event_for_artist

    match '/event/:id/join', to: 'attendees#join', as: :join_event
    match '/event/:id/leave', to: 'attendees#leave', as: :leave_event

  end

  # Routes for landing site
  constraints subdomain: "www" do
    get "errors/not_found"
    get "errors/server_error"
    get "errors/unprocessable"
    get "errors/access_denied"
    get "login/destroy"
    get "login_controller/destroy"
    match '/make_beta_tester' => 'users#make_beta_tester', via: :get, as: :make_beta_tester

    root to: 'static_pages#home'

    match '/market', to: 'static_pages#market', as: :market
    match '/team', to: 'static_pages#team', as: :team
    match '/news', to: 'static_pages#news', as: :news
    match '/careers', to: 'static_pages#careers', as: :jobs
    match '/contact', to: 'static_pages#contact', as: :contact
    match '/beta', to: 'static_pages#beta', as: :beta
    match '/terms', to: 'static_pages#terms', as: :terms
    match '/logout', to: 'login_#destroy', as: :logout
  end

  root to: 'static_pages#home'

  # Any routes that aren't defined go to 404
  match "*a", to: 'errors#not_found'

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
