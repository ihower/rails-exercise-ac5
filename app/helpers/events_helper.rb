module EventsHelper

  def event_status_options
    #[ ["Published", "published"], ["Draft", "draft"] ]

    Event::STATUS.map do |x|
      [ I18n.t(x, :scope => "events"), x ]
    end
  end

end
