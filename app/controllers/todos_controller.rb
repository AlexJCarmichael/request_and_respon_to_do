
class ToDosController < ApplicationController
  def index
    render App.todos.to_json
  end
end
