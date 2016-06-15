Rails.application.routes.draw do

  namespace :v1 do
    resources :blogs, except: [:new, :edit] do
      resources :comments, only: [:create, :update, :destroy]
    end

    get '/comments/recent' => 'comments#recent'
  end
end
