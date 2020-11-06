Rails.application.routes.draw do
  root to: "markers#index"
  resources :types do 
    collection do
      get :chart
    end
  end
  resources :markers
  resources :categories do
    collection do 
      post :create_subcategory
      get :category_detail
    end 
    member do 
      get :add_subcategory
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
