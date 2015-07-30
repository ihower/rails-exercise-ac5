class TodosController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
    @todos = Todo.all.order("id DESC")

    respond_to do |format|
      format.html {
        gon.data = { :todos => @todos }
      }
      format.json {
        render :json => { :todos => @todos }
      }
    end
  end

  # POST /todos
  def create
    @todo = Todo.new( :title => params[:title] )
    @todo.save!

    render :json => { :todo => @todo }
  end

  # PATCH /todos/:id
  def update
    @todo = Todo.find(params[:id])
    @todo.update!( :title => params[:title] )

    render :json => { :todo => @todo }
  end

  # DELETE /todos/:id
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    render :json => { :message => "OK" }
  end

end
