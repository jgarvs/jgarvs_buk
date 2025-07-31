require_relative '../../lib/email_provider'
require_relative '../../lib/sms_provider'
require_relative '../../lib/whatsapp_provider'

class Notification < ApplicationRecord
    def Process()
        # Read specific company configuration to decide if channel is available 
        company_config = canal_company_configuration[self.company_configuration_reference]
        Async do
            EmailProvider.try_send(self, company_config)
            SmsProvider.try_send(self, company_config)
            WhatsappProvider.try_send(self, company_config)
        end
    end
end
