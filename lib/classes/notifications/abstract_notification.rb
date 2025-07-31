require 'async'
class AbstractNotification
    
    private
    attr_reader :notification_data

    # How to prevent inherited classes from changing methods
    def self.method_added(method_name)
        if @prevent_overrides && instance_methods(false).include?(method_name)
            raise "No puedes sobreescribir el método #{method_name}"
        end
    end

    def self.lock_methods!
        @prevent_overrides = true
    end

    def initialize
        @notification_data = Notification.new
    end

    def send(company_configuration_reference)
        #configuration : json

        self.notification_data.company_configuration_reference = company_configuration_reference
        # self.notification_data.any_extra_parameters = ""
        # Store notification data on DB
        self.notification_data.save
        # Store notification on Delay Job
        priority = 100

        if self.notification_data.urgent
            priority = 1
        end
        NotificationQueueJob.set(priority: priority).perform_later(self.notification_data)
    end

    def setup_notification(sender, tittle, body, urgent, recipients)
        set_sender(sender)
        set_tittle(tittle)
        set_body(body)
        set_urgent(urgent)
        add_recipients( recipients )
    end

    def set_sender(sender)
        self.notification_data.sender = sender
    end

    def set_urgent(urgent)
        self.notification_data.urgent = urgent
    end

    def set_tittle(tittle)
        self.notification_data.tittle = tittle
    end

    def set_body(body)
        self.notification_data.tittle = body
    end
    
    def add_recipient( recipient )
        self.notification_data.recipients << recipient
    end
        
    def add_recipients( new_recipients )
        self.notification_data.concat(new_recipients)
    end

    lock_methods!
end