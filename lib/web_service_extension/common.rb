module WebServiceExtension
  module Common
  
    # Gets the current account.
    def current_account
      WebServiceExtension::Account.first
    end

  end
end
