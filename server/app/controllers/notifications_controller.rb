class NotificationsController < ApplicationController

  # GET /notifications
  def index
    @notifications = Notification.all

    render json: @notifications
  end

end
