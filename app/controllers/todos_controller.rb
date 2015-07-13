class TodosController < ApplicationController

  def index
    @todos = Todo.all

    respond_to do |format|
      format.html {
        gon.data = { :todos => @todos }
      }
      format.json
    end
  end

  # DELETE /todos/:id
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    render :json => { :message => "OK" }
  end

end
