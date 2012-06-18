require 'spec_helper'

describe Notification do

  it { respond_to :external_identifier }
  it { respond_to :description }
  it { respond_to :service }
  it { respond_to :severity }

end
