AP::WebServiceExtension::WebService::config_account({:endpoint => "http://192.168.1.3:8080/Meep/Meep?WSDL", :action => "hello"})

class ActionController::Base
  def authenticate_admin!; end
end