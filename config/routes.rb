Rails.application.routes.draw do
    resources :messages
    resources :msg_threads
    resources :pages
    root 'site#index'

    devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        omniauth_callbacks: 'users/omniauth_callbacks'
    }

    post '/msg_threads/more(.:format)', to: 'msg_threads#more'
end
