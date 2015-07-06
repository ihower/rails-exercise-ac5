class EventsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  before_action :set_event, :only => [:show, :dashboard, :edit, :update, :destroy]

  # GET /events/index
  # GET /events
  def index
    if params[:eid]
      @event = Event.find_by_friendly_id( params[:eid] )
    else
      @event = Event.new

      @event.friendly_id = SecureRandom.hex(10)

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

  # GET /events/latest
  def latest
    @events = Event.order("id DESC").limit(3)
  end

  # GET /events/:id
  def show
    @attendees = @event.attendees.page(params[:page]).per(10)

    if cookies["view-event-#{@event.id}"]
      # do nothing
    else
      #@event.increment!(:views_count)
      Rails.logger.debug("Event Hit! : #{@event.id}" )

      cookies["view-event-#{@event.id}"] = "yes!"
    end

    if @attendees.last_page?
      @next_page = nil
    else
      @next_page = @attendees.next_page
    end

    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.js
      format.json {
        render :json => { id: @event.id, name: @event.name, created_time: @event.created_at }.to_json
      }
    end
  end

  # GET /events/:id/dashboard
  def dashboard

  end

  # POST /events
  def create
    @event = Event.new( event_params )

    @event.user = current_user

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
    if params[:_remove_logo] == "1"
      @event.logo = nil
    end

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

  # POST /events/bulk_update
  def bulk_update
    ids = Array( params[:ids] )
    events = ids.map{ |i| Event.find_by_id(i) }.compact

    if params[:commit] == "Delete"
      events.each { |e| e.destroy }
    elsif params[:commit] == "Publish"
      events.each { |e| e.update( :status => "published") }
    end

    redirect_to :back
  end

  private

  def set_event
    @event = Event.find_by_friendly_id( params[:id] )
  end

  def event_params
    params.require(:event).permit(:name, :logo, :description, :category_id, :status,
                                  :start_on, :tag_list, :friendly_id, :group_ids => [] )
  end

  def prepare_variable_for_index_template

    gon.tags = Tag.all.map{ |x| x.name }

    if params[:keyword]
      @events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ] )
    else
      @events = Event.order("id DESC")
    end

    if params[:order]
      sort_by = (params[:order] == 'name') ? 'name' : 'id'
      @events = @events.order(sort_by)
    end

    @events = @events.page( params[:page] ).per(10)
  end

end
