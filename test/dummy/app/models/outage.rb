class Outage
  include Mongoid::Document
  include Mongoid::Timestamps
  include AP::WebServiceExtension::WebService
  
  field :"title", type: String
  
  def save
    super
    Rails.logger.info "Sending WS request: #{self.id}"
    web_service_perform(self)
    true
  end
end
