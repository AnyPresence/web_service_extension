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
        if config.empty?
          raise "Nothing to configure!"
        end
        config = HashWithIndifferentAccess.new(config)
        
        @@config.merge!(config)
      end
      
      # Builds request for webservice.
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
        
        basic_auth_hash = @@config[:basic_auth_hash]
        
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
