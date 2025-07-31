class NotificationQueueJob < ApplicationJob
  queue_as :default

  def perform(notification)
    # Do something later
    notification.Process()
  end
end
