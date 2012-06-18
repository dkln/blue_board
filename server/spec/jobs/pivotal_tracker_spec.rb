require 'spec_helper'

describe Pivotal do

  let(:activity) { stub(id: "42", description: "Foo") }

  before do
    PivotalTracker::Activity.stub(:all) { [activity] }
  end

  it 'retrieves the last activities from Pivotal' do
    PivotalTracker::Activity.stub(:all) { [activity] }

    Pivotal.perform.should == [activity]
  end

  it 'checks if the activity has already been processed' do
    Notification.should_receive(:find_by_external_identifier).with("42")
    Pivotal.perform
  end

  context 'with activity processed' do

    before { Notification.stub(:find_by_external_identifier) { true } }

    it 'does not insert a new notification' do
      Notification.should_not_receive(:new)
      Pivotal.perform
    end

  end

  context 'with activity not processed' do

    before { Notification.stub(:find_by_external_identifier) { false } }

    it 'inserts a new notification' do

      notification = mock_model("Notification").as_null_object
      notification.should_receive(:save!)

      Notification.stub(:new) { notification }
      Pivotal.perform
    end

    it 'stores the activities attributes in the notification' do
      Pivotal.perform

      notification = Notification.first
      notification.service.should             == "pivotal"
      notification.external_identifier.should == "42"
      notification.description.should         == "Foo"
    end
  end
end

