class UbikesController < ApplicationController

  def index
    @ubikes = Ubike.all
  end

end
