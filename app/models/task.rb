$given_ids = 0
class Task
  attr_accessor :body, :id, :completed
  def initialize(body, completed = false)
    @body = body
    @id = get_id
    @completed = completed
  end

  def to_json(_ = nil)
   {
    body: body,
    completed: completed,
    }.to_json
  end

  def get_id
    $given_ids +=1
  end
end
