require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /events" do
    it "should events list" do
      Event.create!( :name => "Foooooo")

      get "/api/v1/events"

      data = {
        "data" => [{
          "name" => "Foooooo"
        }],
        "pagination" => {
          "page" => 123
        }
      }

      expect(response).to have_http_status(200)
      expect( JSON.parse(response.body) ).to eq( data )
    end
  end

  describe "POST /events" do
    it "should create event failed" do
      post "/api/v1/events"

      expect(response).to have_http_status(400)
    end

    it "should create event successfully" do
      post "/api/v1/events", :name => "QQQ"

      event = Event.last
      data = {
        "message" => "OK",
        "id" => event.id
      }

      expect( JSON.parse(response.body) ).to eq( data )
      expect(response).to have_http_status(200)

      expect(event.name).to eq("QQQ")
    end

  end

end
