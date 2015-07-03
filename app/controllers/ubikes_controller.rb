class UbikesController < ApplicationController

  def index
    conn = Faraday.new(:url => 'http://data.taipei' )
    res = conn.get '/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5'
    data = JSON.parse( res.body )

    @ubikes = data["result"]["results"]
  end

end
