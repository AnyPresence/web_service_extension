class WebServiceExtension::ApplicationController < ApplicationController
  layout 'layouts/admin'
  
  before_filter :authenticate_admin!
end

