Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/olympians', to: 'olympians#index'
    end
  end
end
