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
      
      def web_service_perform(object_instance, options={})
        
      end
      
    end
  end
end
