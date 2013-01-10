WebServiceExtension::Engine.routes.draw do
  match 'settings' => 'settings#index'
  
  root :to => "settings#index"
end
