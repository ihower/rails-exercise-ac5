class EventsController < ApplicationController

  # GET /events/index
  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/show/:id
  def show
    @event = Event.find( params[:id] )
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events/create
  def create
    @event = Event.new( event_params )

    @event.save

    redirect_to :action => :index # 告訴瀏覽器 HTTP code: 303
  end

  # GET /events/edit/:id
  def edit
    @event = Event.find( params[:id] )
  end

  # POST /events/update/:id
  def update
    @event = Event.find( params[:id] )

    @event.update( event_params )

    redirect_to :action => :show, :id => @event
  end

  # GET /events/destroy/:id
  def destroy
    @event = Event.find( params[:id] )

    @event.destroy

    redirect_to :action => :index
  end

  private

  def event_params
    params.require(:event).permit(:name, :description)
  end

end
