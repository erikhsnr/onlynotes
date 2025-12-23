Rails.application.routes.draw do

  devise_for :users

  #resources :fach, only: [] do
  #  resources :posts, except: [:index], param: :postID
  #end
  get "/fachbereich/:id", to: "fachbereich#index", as: "fachbereich"
  get "/studiengang/:id", to: "studiengang#index", as: "studiengang"

  get "/kurs/:id", to: "fach#index", as: "posts"
  post "kurs/:id", to: "fach#following", as: "follow"
  post "/search/new", to: "search#create", as: "new_kurs"


  post 'posts/:post_id/likes', to: 'likes#create', as: 'post_likes'
  delete 'posts/:post_id/likes/:id', to: 'likes#destroy', as: 'post_like'


  get "/kurs/:id/posts/new", to: "posts#new", as: "new_post" 
  get "/kurs/:id/posts/:postID", to: "posts#show", as: "show_post"
  
  post "/kurs/:id/posts", to: "posts#create", as: "kurs_post"
  delete "/kurs/:id/posts/:postID", to: "posts#destroy"

  get "/bildungseinrichtung/:id", to: "bildungseinrichtung#index", as: "edu"
  get "/fachbereich/:id", to: "fachbereich#index", as: "fb"
  get "/studiengang/:id", to: "studiengang#index", as: "gang"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  get "/home" => "start#index", as: "home"

  get "/search" => "search#index", as: "kurs_search"
  get "/search/new" => "search#new", as: "kurs_create"

  # Da Kurse, Studiengänge, Fachbereiche und Bildungseinrichtungen immer mit ID abgerufen werden, 
  # wird ein Aufruf der Route ohne ID zur Search Seite geleitet  
  get "/kurs" => "search#index"          
  get "/studiengang" => "search#index"
  get "/fachbereich" => "search#index"
  get "/bildungseinrichtung" => "search#index"
  get "/recht" => "recht#index"
  get "/impressum" => "impressum#index"
  get "/datenschutz" => "datenschutz#index"

  post "/users/sign_out" => "start#index"

  # Defines the root path route ("/")
  root "start#index"

  match '*unmatched', to: 'application#render_not_found', via: :all, constraints: lambda { |req|
    !req.path.start_with?('/rails/active_storage')
  }
end
