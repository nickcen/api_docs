ApiDocs::Application.routes.draw do
  resources :workers do
    collection do
      get :new_user
    end
  end
  
  resources :apps do 
    resources :specs
  end

  get "login" => "workers#login_routing_page", as: "login_routing_page"

  root 'workers#root_welcome_page'
  post 'logout' => 'application#logout', as: 'logout'
end
