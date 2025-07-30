module WhatsappProvider
        def try_send(notification_instance,  company_config)

        is_email_active_for_company = company_config.get_whatsapp()
        if(!is_email_active_for_company)
            return
        end
        # use whatsapp provider to send the notification
        puts "A package of #{notification_instance.recipients.length } recipients where sent"
    end
end