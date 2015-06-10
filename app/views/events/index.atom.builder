atom_feed do |feed|
  feed.title( @feed_title )
  feed.updated( @events.last.created_at )
  @events.each do |event|
    feed.entry(event) do |entry|
      entry.title( event.name )
      entry.content( event.description, :type => 'html' )
    end
  end
end