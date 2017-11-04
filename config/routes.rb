Rails.application.routes.draw do
    root 'site#index'

    devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        omniauth_callbacks: 'users/omniauth_callbacks'
    }
end
