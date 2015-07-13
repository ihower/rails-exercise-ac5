class TodosController < ApplicationController

  def index
    @todos = Todo.all.order("id DESC")

    respond_to do |format|
      format.html {
        gon.data = { :todos => @todos }
      }
      format.json
    end
  end

  # POST /todos
  def create
    @todo = Todo.new( :title => params[:title] )
    @todo.save!

    render :json => { :todo => @todo }
  end

  # DELETE /todos/:id
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    render :json => { :message => "OK" }
  end

end
