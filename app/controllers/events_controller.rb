class EventsController < ApplicationController

  before_action :set_event, :only => [:show, :edit, :update, :destroy]

  # GET /events/index
  # GET /events
  def index

    if params[:eid]
      @event = Event.find( params[:eid] )
    else
      @event = Event.new
      @event.start_on = Date.new(2015,1,1) # assign a default date
    end

    prepare_variable_for_index_template

    respond_to do |format|
      format.html # index.html.erb
      format.xml {
        render :xml => @events.to_xml
      }
      format.json {
        render :json => @events.to_json
      }
      format.atom {
        @feed_title = "My event list"
      } # index.atom.builder
    end

  end

  # GET /events/:id
  def show
    @page_title = @event.name

    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json {
        render :json => { id: @event.id, name: @event.name, created_time: @event.created_at }.to_json
      }
    end
  end

  # POST /events
  def create
    @event = Event.new( event_params )

    if @event.save

      flash[:notice] = "新增成功"

      redirect_to events_path # 告訴瀏覽器 HTTP code: 303
    else

      prepare_variable_for_index_template

      render :action => :index
    end
  end

  # PATCH /events/:id
  def update
    if @event.update( event_params )

      flash[:notice] = "編輯成功"

      redirect_to events_path
    else
      prepare_variable_for_index_template

      render :action => :index
    end
  end

  # DELETE /events/:id
  def destroy
    @event.destroy

    flash[:alert] = "刪除成功"

    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find( params[:id] )
  end

  def event_params
    params.require(:event).permit(:name, :description, :category_id)
  end

  def prepare_variable_for_index_template
    @events = Event.page( params[:page] ).per(10)
  end

end
