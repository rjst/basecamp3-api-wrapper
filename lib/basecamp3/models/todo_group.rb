# A model for Basecamp's TODO Group
#
# {https://github.com/basecamp/bc3-api/blob/master/sections/todolist_groups.md For more information, see the official Basecamp3 API documentation for TODO groups}
class Basecamp3::TodoGroup < Basecamp3::Model
  include Basecamp3::Concerns::Creatorable
  include Basecamp3::Concerns::Bucketable
  include Basecamp3::Concerns::Parentable
  include Basecamp3::Concerns::Recordingable
  include Basecamp3::Concerns::Commentable

  attr_accessor :id,
                :status,
                :created_at,
                :updated_at,
                :name,
                :description,
                :completed,
                :completed_ratio,
                :app_url                

  REQUIRED_FIELDS = %w(name)

  # Returns a list of related todos.
  #
  # @return [Array<Basecamp3::Todo>]
  def todos
    @mapped_todos ||= Basecamp3::Todo.all(bucket.id, id)
  end
    
  # Returns a paginated list of active TODO groups.
  #
  # @param [Hash] params additional parameters
  # @option params [String] :status (optional) when set to archived or trashed, will return archived or trashed to-do lists that are in this to-do list
  # @option params [Integer] :page (optional) to paginate results
  #
  # @return [Array<Basecamp3::TodoList>]
  def self.all(bucket_id, parent_id, params = {})
    Basecamp3.request.get("/buckets/#{bucket_id}/todolists/#{parent_id}/groups", params, Basecamp3::TodoList)
  end

  # Returns the TODO group.
  #
  # @param [Integer] bucket_id the id of the bucket
  # @param [Integer] id the id of the TODO group
  #
  # @return [Basecamp3::TodoList]
  def self.find(bucket_id, id)
    Basecamp3.request.get("/buckets/#{bucket_id}/todolists/#{id}", {}, Basecamp3::TodoList)
  end

end