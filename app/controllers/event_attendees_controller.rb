class EventAttendeesController < ApplicationController

  before_action :set_event

  def index
    @attendees = @event.attendees
  end

  def show
    @attendee = @event.attendees.find( params[:id] )
  end

  def new
    @attendee = @event.attendees.build
    # @attendee = @event.attendees.new
  end

  def create
    @attendee = @event.attendees.build( attendee_params )

    if @attendee.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Done!"
          redirect_to :back #event_attendees_path(@event)
        }
        format.js
      end
    else
      respond_to do |format|
        format.html {
          render :action => "new"
        }
        format.js # create.js.erb
      end
    end
  end

  def edit
    @attendee = @event.attendees.find( params[:id] )

    respond_to do |format|
      format.html
      format.js # edit.html.erb
    end
  end

  def update
    @attendee = @event.attendees.find( params[:id] )

    if @attendee.update( attendee_params )
      respond_to do |format|
        format.html {
          redirect_to event_attendees_path(@event)
        }
        format.js # update.js.erb
      end
    else
      render :action => "edit"
    end
  end

  def destroy
    @attendee = @event.attendees.find( params[:id] )

    @attendee.destroy

    respond_to do |format|
      format.html {
        redirect_to event_attendees_path(@event)
      }
      format.js
    end
  end

  protected

  def attendee_params
    params.require(:attendee).permit(:name)
  end

  def set_event
    @event = Event.find_by_friendly_id( params[:event_id] )
  end

end
