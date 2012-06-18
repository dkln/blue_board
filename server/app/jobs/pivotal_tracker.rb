require 'pivotal-tracker'

module Pivotal

  @queue = :notifications

  def self.perform
    PivotalTracker::Client.token = 'TOKEN'

    @activities = PivotalTracker::Activity.all

    @activities.each do |activity|
      notification = Notification.find_by_external_identifier(activity.id)

      unless notification
        notification = Notification.new
        notification.service             = :pivotal
        notification.external_identifier = activity.id
        notification.description         = activity.description
        notification.save!
      end
    end
  end

end

