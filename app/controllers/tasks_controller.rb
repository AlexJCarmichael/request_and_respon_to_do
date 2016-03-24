
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
