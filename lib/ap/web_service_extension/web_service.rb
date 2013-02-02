require "savon"
require "faraday"

module AP
  module WebServiceExtension
    module WebService
      include ::WebServiceExtension::Common
      
      @@config = HashWithIndifferentAccess.new
      
      # Creates the account.
      # +config+ configuration properties should contain
      def self.config_account(config={})
        config = HashWithIndifferentAccess.new(config)
        
        config[:username] = ENV['AP_WEB_SERVICE_NOTIFIER_USERNAME']
        config[:password] = ENV['AP_WEB_SERVICE_NOTIFIER_PASSWORD']
        
        @@config.merge!(config)
      end
      
      def self.json_config
        @@json ||= ActiveSupport::JSON.decode(File.read("#{File.dirname(__FILE__)}/../../../manifest.json"))
      end
      
      # Builds request for websheervice.
      #  +object_instance+ is the object instance
      #  +options+ is a hash that includes: +endpoint+ the endpoint to connect to, +action+ soap action
      def web_service_perform(object_instance, options={})
        if @@config[:disabled]
          Rails.logger.info "Extension has been disabled."
          return
        end
        
        options = HashWithIndifferentAccess.new(options)
        endpoint = @@config[:endpoint]
        if endpoint.blank?
          Rails.logger.error ":endpoint must not be blank"
          return
        end
        
        basic_auth_hash = ::AP::WebServiceExtension::HttpUtility.basic_auth_hash(@@config[:username], @@config[:password])
        
        # Check if endpoint is to WSDL
        if endpoint.downcase.end_with?("wsdl")
          # Use soap client
          client = Savon.client(endpoint)

          client.http.headers["Authorization"] = basic_auth_hash unless basic_auth_hash.blank?

          if options[:action].blank?
            Rails.logger.error ":action must not be blank."
            return
          end
          
          response = client.request(options[:action].to_sym) do
            soap.body = object_instance.attributes
          end
          
          return response.body
        else
          httpUtility = ::AP::WebServiceExtension::HttpUtility.new(endpoint)
          httpUtility.setup_connection
          # Check if basic auth is required
          httpUtility.http_connection.headers[:authorization] = basic_auth_hash unless basic_auth_hash.blank?
          response = httpUtility.post(endpoint, object_instance.attributes)
          return response
        end
      end
      
    end
  end
end
