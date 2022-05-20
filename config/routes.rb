Rails.application.routes.draw do
  root 'home#index'

  resources :registers, only: [:index, :create]
  resources :dashboard, only: [:index]

  resources :login, only: [:index, :create, :destroy] do
    collection do 
      delete 'delete', action: :destroy, as: :destroy
    end
  end
end


/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$*&@#])[0-9a-zA-Z$*&@#]{8,128}$/

/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$*&@#])[0-9a-zA-Z$*&@#]{8,128}$/