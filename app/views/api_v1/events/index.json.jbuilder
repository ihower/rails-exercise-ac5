json.data @events do |event|
  json.partial! "show", collection: @events, :as => :event
end

json.paging do

  json.current_page @events.current_page
  json.total_pages @events.total_pages
  json.per_page @events.limit_value
  json.next_url (@events.last_page?)? nil : v1_events_url( :page => @events.next_page )
  json.previous_url (@events.first_page?)? nil : v1_events_url( :page => @events.prev_page )

end