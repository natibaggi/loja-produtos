Rails.application.routes.draw do
  resources :departamentos
  get "produtos", to: "produtos#new"
  get "produtos/busca", to: "produtos#busca", as: :busca_produto

  get "produtos/:id/edit", to: "produtos#edit"

  resources :produtos, only: [:new, :create, :destroy, :edit, :update]

  root to: "produtos#index"
end
