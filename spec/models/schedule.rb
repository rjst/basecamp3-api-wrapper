require 'spec_helper'

describe 'Schedule Model' do
  include RequestHelpers
  include JSONFixtures

  before(:each) do
    @fixtures_object = 'schedule.json'

    @bucket_id = '12345'
    @id = '12345'

    establish_connection
  end

  describe 'Class' do
    it 'returns a specific schedule' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/schedules/#{@id}", @fixtures_object)

      schedule = Basecamp3::Schedule.find(@bucket_id, @id)
      expected_schedule = json_to_model(@fixtures_object, Basecamp3::Schedule)

      expect(schedule).to be_instance_of Basecamp3::Schedule
      expect(schedule.id).to eq(expected_schedule.id)
    end
  end

  describe 'Object' do
    it 'returns a list of entries' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/schedules/#{@id}", @fixtures_object)

      schedule = Basecamp3::Schedule.find(@bucket_id, @id)

      stub_http_request(:get, "/buckets/#{schedule.bucket.id}/schedules/#{schedule.id}/entries", 'schedule_entries.json')

      expect(schedule.entries).to all be_instance_of(Basecamp3::ScheduleEntry)
    end

    it 'is creatorable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/schedules/#{@id}", @fixtures_object)

      schedule = Basecamp3::Schedule.find(@bucket_id, @id)
      expect(schedule.creator).to be_instance_of(Basecamp3::Person)
    end

    it 'is bucketable' do
      stub_http_request(:get, "/buckets/#{@bucket_id}/schedules/#{@id}", @fixtures_object)

      schedule = Basecamp3::Schedule.find(@bucket_id, @id)
      expect(schedule.bucket).to be_instance_of(Basecamp3::Project)
    end
  end
end