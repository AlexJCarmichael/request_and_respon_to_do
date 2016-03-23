class Task
  attr_accessor :body, :id, :completed
  def initialize(body, id, completed = false)
    @body = body
    @id = id
    @completed = completed
  end

  def to_json(_ = nil)
   {
    body: body,
    completed: completed,
    }.to_json
  end
end
