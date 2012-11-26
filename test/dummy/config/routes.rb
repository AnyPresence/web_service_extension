Rails.application.routes.draw do

  mount WebServiceExtension::Engine => "/web_service_extension"
end
