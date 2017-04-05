Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlsdevise_for :usuarios
  #resources :usuarios,
  #:defaults => { :format => :json },
  #:only => [:index, :show]
  get 'usuario/' => 'usuarios#index', :defaults => { :format => :json }
  get 'usuario/:id' => 'usuarios#show', :defaults => { :format => :json }
  put 'usuario/' => 'usuarios#create', :defaults => { :format => :json }
  post 'usuario/:id' => 'usuarios#update', :defaults => { :format => :json }
  delete 'usuario/:id' => 'usuarios#destroy', :defaults => { :format => :json }

end
