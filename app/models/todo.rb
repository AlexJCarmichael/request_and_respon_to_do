
class ToDo
 def initialize(body, complelted = false)
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
