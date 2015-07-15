class ApiV1::EventsController < ApiController

  def index
    @events = Event.order("id DESC").page( params[:id] )
  end

  def create
    @event = Event.new( :name => params[:name] )

    if @event.save
      render :json => { :message => "OK", :id => @event.id }
    else
      render :json => { :errors => @event.errors.full_messages }, :status => 400
    end
  end

end
