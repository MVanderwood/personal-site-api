Rails.application.routes.draw do
  namespace :v1 do
    resources :blogs
  end
end
