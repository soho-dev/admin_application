class DashboardController < ApplicationController

  def index
    respond_to do |format|
      # format.html
      format.json  { render :json => "xxxxxxxx" }
    end
  end
end
