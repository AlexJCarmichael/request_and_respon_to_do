
class TasksController < ApplicationController
  def index
    if request[:format] == "json"
      render App.tasks.to_json
    else
      @tasks = App.tasks
      render_template 'tasks/index.html.erb'
    end
  end
end
