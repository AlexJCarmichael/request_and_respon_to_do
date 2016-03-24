# Request / Response MVC!

This app will follow the Model, View, Controller method that rails uses. The user can create and view tasks for a to do list. This is accomplished with the CRUD method of persistant storage. This readme will break down how each element of CRUD is implemented in this program.

All actions are preformed by accessing a server with 

```http://localhost:3001/tasks```

All of the tasks are Ruby objects which have three values, a body containing the task, a completion status which is set to false by default, and an ID which is created based on how many tasks currently exist. The only argument that needs to be provided to create a new class is a body argument.

```rb
# ./app/models/task.rb
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
```

###Create
In order to create a new task the server (http://localhost:3001/tasks) must be given a post command. The post HTTP command must be sent with a body message that will communicate with the body argument of the task in order to create  new task.

```rb
def create
    task = Task.new(params["body"])
    App.tasks.push(task)
    if request[:format] == "json"
      render task.to_json
    else
      @task = task
      render_template 'tasks/create.html.erb'
    end
  end
```
###Update
In order to update a task the server must be told which task to update (http://localhost:3001/tasks/:ID with ID being the number of the task) with a puts HTTP command. Along with the puts command a body message must be sent. This body message can have up to two arguments, one that speaks to the body variable of the task and one that speaks to the completed variable of the task.

```rb
  def update
    task = App.tasks.find { |t| t.id == params[:id].to_i }
    if params["body"] && params["completed"]
      task.body = params["body"]
      task.completed = params["completed"]
      if request[:format] == "json"
        render task.to_json
      else
        @task = task
        render_template 'tasks/update.html.erb'
      end
    elsif params["body"]
      task.body = params["body"]
      if request[:format] == "json"
        render task.to_json
      else
        @task = task
        render_template 'tasks/update.html.erb'
      end
    elsif params["completed"]
      task.completed = params["completed"]
      if request[:format] == "json"
        render task.to_json
      else
        @task = task
        render_template 'tasks/update.html.erb'
      end
    else
      render_not_found
    end
  end
```

###Read

The tasks can be read either as a list or individually. To read the entire list the server must be given the HTTP command GET along with http://localhost:3001/tasks.

```rb
def index
    if request[:format] == "json"
      render App.tasks.to_json
    else
      @tasks = App.tasks
      render_template 'tasks/index.html.erb'
    end
  end
```
An individual task can be read by giving the HTTP command GET  along with http://localhost:3001/tasks/:id with the :id being the number of the task you wish to display.

```rb
def show
    task = App.tasks.find { |t| t.id == params[:id].to_i }
    if task
      if request[:format] == "json"
        render task.to_json
      else
        @to_print = task.body
        render_template 'tasks/show.html.erb'
      end
    else
      render_not_found
    end
  end
```

###Delete
Deleting an individual task is accomplished by giving the server the HTTP command Delete and http://localhost:3001/tasks/:id with the :id being the number of the task you wish to delete.

```rb
def destroy
    task = App.tasks.find { |t| t.id == params[:id].to_i }
    if task
      App.tasks.delete(task)
      if request[:format] == "json"
        render task.to_json
      else
        @task = task
        render_template 'tasks/delete.html.erb'
      end
    else
      render_not_found
    end
  end
```

###Display
All of the tasks display as HTML by default. Json can be displayed by adding .json to the url request. Each of the methods above call a method of render_not_found as an esle statement. Render_not_found will give a 404 status back as well as displaying a message in either HTML or json depending on the url.

```rb
def render_not_found
    if request[:format] == "json"
      return_message = {
        message: "Task not found!",
        status: '404'
      }.to_json
      render return_message, status: "404 NOT FOUND"
    else
      render_template 'tasks/not_found.html.erb', status: "404 NOT FOUND"
    end
  end
```