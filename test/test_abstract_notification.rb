require 'minitest/autorun'
require_relative '../lib/clases/notifications/abstract_notification'
require_relative '../app/models/notification'
require_relative '../app/jobs/notification_queue_job'

class DummyNotification < AbstractNotification
  public :setup_notification, :send
end

class TestAbstractNotification < Minitest::Test
  def setup
    @notification = DummyNotification.new
  end

  def test_setup_notification_sets_data
    @notification.setup_notification("bot", "Test", "Mensaje de prueba", true, ["user@example.com"])
    notif = @notification.send(:notification_data)

    assert_equal "bot", notif.sender
    assert_equal "Test", notif.tittle
    assert_equal true, notif.urgent
    assert_equal ["user@example.com"], notif.recipients
  end

  def test_send_enqueues_delayed_job
    @notification.setup_notification("bot", "Test", "msg", false, ["a"])
    job = Minitest::Mock.new
    job.expect(:perform_later, nil, [Notification])

    NotificationQueueJob.stub :set, job do
      @notification.send(42)
    end

    job.verify
  end

  def test_send_sets_company_config_ref
    @notification.setup_notification("bot", "Test", "msg", false, ["a"])
    @notification.send(123)

    notif = @notification.send(:notification_data)
    assert_equal 123, notif.company_configuration_reference
  end

  def test_send_sets_priority_based_on_urgency
    urgent = DummyNotification.new
    urgent.setup_notification("bot", "Urgente", "msg", true, ["a"])

    mock_job = Minitest::Mock.new
    mock_job.expect(:perform_later, nil, [Notification])

    NotificationQueueJob.stub(:set, ->(args) {
      assert_equal 1, args[:priority]
      mock_job
    }) do
      urgent.send(1)
    end

    mock_job.verify
  end
end
