class Admin::EventsController < ApplicationController

  before_action :authenticate

  layout "admin"

  def index
    @events = Event.all
  end

  protected

  def authenticate
     authenticate_or_request_with_http_basic do |user_name, password|
         user_name == "username" && password == "password"
     end
  end


end
