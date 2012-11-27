class Outage
  include Mongoid::Document
  include Mongoid::Timestamps
  include AP::WebServiceExtension::WebService
  
  field :"title", type: String
  
  def save
    super
    Rails.logger.info "Sending WS request: #{self.id}"
    web_service_perform(self, {:endpoint => "http://192.168.1.3:8080/Meep/Meep?WSDL", :action => "hello"})
    true
  end
end
