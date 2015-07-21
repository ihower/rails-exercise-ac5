class FoobarWorkerJob < ActiveJob::Base
  queue_as :default

  def perform
    Rails.logger.info("Hard work!")
  end
end
