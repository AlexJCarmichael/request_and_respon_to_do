class Task
  attr_accessor :body, :completed
  def initialize(body, completed = false)
    @body = body
    @completed = completed
  end

  def to_json(_ = nil)
   {
    body: body,
    completed: completed,
    }.to_json
  end
end
