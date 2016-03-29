CaixaEletronico::Application.routes.draw do

  devise_for :clientes, controllers: {registrations: 'registrations'}

  root "caixa#index"
  get "caixa/index"

  get "contas/index"
  get "contas/show"
  get "contas/new"
  get "contas/edit"
  get "contas/create"
  get "contas/update"
  get "contas/destroy"

  get "movimentacoes/index"
  get "movimentacoes/show"
  get "movimentacoes/new"
  get "movimentacoes/edit"
  get "movimentacoes/create"
  get "movimentacoes/update"
  get "movimentacoes/destroy"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"

  resources :clientes do
    resources :contas do
      get "extrato/show"
      patch "extrato/show"
      get "saldo/show"
      resources :movimentacoes
    end
  end

  resources :movimentacoes, :only => [:new, :create, :show]

  #erro 404 - tratando
  get "*any", via: :all, to: "caixa#not_found"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
