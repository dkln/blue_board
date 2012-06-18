class Notification < ActiveRecord::Base
  attr_accessible :description, :external_identifier, :service, :severity
end
