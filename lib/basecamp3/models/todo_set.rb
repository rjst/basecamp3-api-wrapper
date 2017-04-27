class Basecamp3::TodoSet < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :name,
                :todolists_count,
                :completed,
                :completed_ratio

  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/todosets/#{id}", {}, Basecamp3::TodoSet)
  end
end