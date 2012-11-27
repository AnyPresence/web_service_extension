Rails.application.routes.draw do

  resources :outages


  mount WebServiceExtension::Engine => "/web_service_extension"
end
