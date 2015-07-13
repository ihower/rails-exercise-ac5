class WelcomeController < ApplicationController


  def spa
    gon.time = Time.now.to_s

    respond_to do |format|
      format.html
      format.json {
        render :json => { :time => Time.now }
      }
    end
  end

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
