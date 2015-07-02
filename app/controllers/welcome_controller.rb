class WelcomeController < ApplicationController

  def say
  end

  def index
  end

  def jquery
  end

  def ajax
  end

  def ajaxtest
    @time = Time.now

    respond_to do |format|
      format.html { render :layout => false }
      format.json {
        render :json => { :foo => 123, :t => Time.now }
      }
      format.js
    end
  end

end
