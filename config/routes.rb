Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlsdevise_for :usuarios
  resources :usuarios,
  :defaults => { :format => :json },
  :only => [:show, :create]
end
