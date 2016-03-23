
class TasksController < ApplicationController
  def index
    if request[:format] == "json"
      render App.tasks.to_json
    else
      @tasks = App.tasks
      render_template 'tasks/index.html.erb'
    end
  end
  
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


  private

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
end
