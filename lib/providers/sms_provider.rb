module SmsProvider
        def self.try_send(notification_instance, company_config)

        is_email_active_for_company = company_config.get_sms()
        if(!is_email_active_for_company)
            return
        end
        # use sms provider to send message
        puts "A package of #{notification_instance.recipients.length } recipients where sent"
    end
end