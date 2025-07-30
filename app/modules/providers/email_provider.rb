module EmailProvider
    def try_send(notification_instance, company_config)

        #Get company configuration for emails
        
        is_email_active_for_company = company_config.get_email()
        if(!is_email_active_for_company)
            return
        end
        # use SendGrid to send the email package
        puts "A package of #{notification_instance.recipients.length } recipients where sent"
    end
end